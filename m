Return-Path: <SRS0=qceG=5T=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=qceG=5T=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 14 Jun 2017 07:00:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	kernel test robot <fengguang.wu@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, LKP <lkp@01.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	wfg@linux.intel.com, Alan Cox <alan@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	David Airlie <airlied@linux.ie>,
	David Herrmann <dh.herrmann@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable
 to handle kernel NULL pointer dereference at 00000000000000a8
Message-ID: <20170614050049.GA11630@kroah.com>
References: <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <20170613041842.GA13308@kroah.com>
 <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com>
 <20170613043416.GB14217@kroah.com>
 <20170613043518.GA14621@kroah.com>
 <8462abee-0a7f-00fb-6111-1f78362ea3f7@deltatee.com>
 <20170613163508.GA31961@kroah.com>
 <f848a5fb-096c-a025-cc3b-314cc3899f9e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f848a5fb-096c-a025-cc3b-314cc3899f9e@deltatee.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 11:47:30AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 13/06/17 10:35 AM, Greg Kroah-Hartman wrote:
> > For char devices, I doubt it, but we can't take the chance, which is why
> > you make it an option.  Then, it's enabled for 'allmodconfig' builds,
> > which helps testers out.
> 
> Well I took a look at this and it looks like a lot of work to modify all
> the drivers to support a possible dynamic allocation and I'm not really
> able to do all that right now.

No, don't modify any drivers, do this in the core chardev code.

> However, correct me if I'm missing something, but it looks fairly
> straightforward to extend the dynamic region above 256 in cases like
> this. There are already fixed major numbers above 255 and the
> infrastructure appears to support it. So what are your thoughts on the
> change below? I'd be happy to clean it up into a proper patch if you
> agree it's a workable option.
> 
> Thanks,
> 
> Logan
> 
> 
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index fb8507f521b2..539352425d95 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -59,6 +59,29 @@ void chrdev_show(struct seq_file *f, off_t offset)
> 
>  #endif /* CONFIG_PROC_FS */
> 
> +static int find_dynamic_major(void)
> +{
> +	int i;
> +	struct char_device_struct **cp;
> +
> +	for (i = ARRAY_SIZE(chrdevs)-1; i > CHRDEV_MAJOR_DYN_END; i--) {
> +		if (chrdevs[i] == NULL)
> +			return i;
> +	}
> +
> +	for (i = CHRDEV_MAJOR_DYN_EXT_START;
> +	     i > CHRDEV_MAJOR_DYN_EXT_END; i--) {
> +		for (cp = &chrdevs[major_to_index(i)]; *cp; cp = &(*cp)->next)
> +			if ((*cp)->major == i)
> +				break;
> +
> +		if (*cp == NULL || (*cp)->major != i)
> +			return i;
> +	}
> +
> +	return -EBUSY;
> +}
> +
>  /*
>   * Register a single major with a specified minor range.
>   *
> @@ -84,22 +107,11 @@ __register_chrdev_region(unsigned int major,
> unsigned int baseminor,
> 
>  	mutex_lock(&chrdevs_lock);
> 
> -	/* temporary */
>  	if (major == 0) {
> -		for (i = ARRAY_SIZE(chrdevs)-1; i > 0; i--) {
> -			if (chrdevs[i] == NULL)
> -				break;
> -		}
> -
> -		if (i < CHRDEV_MAJOR_DYN_END)
> -			pr_warn("CHRDEV \"%s\" major number %d goes below the dynamic
> allocation range\n",
> -				name, i);
> -
> -		if (i == 0) {
> -			ret = -EBUSY;
> +		ret = find_dynamic_major();
> +		if (ret < 0)
>  			goto out;
> -		}
> -		major = i;
> +		major = ret;
>  	}
> 
>  	cd->major = major;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 249dad4e8d26..5780d69034ca 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2448,6 +2448,9 @@ static inline void bd_unlink_disk_holder(struct
> block_device *bdev,
>  #define CHRDEV_MAJOR_HASH_SIZE	255
>  /* Marks the bottom of the first segment of free char majors */
>  #define CHRDEV_MAJOR_DYN_END 234
> +#define CHRDEV_MAJOR_DYN_EXT_START 511
> +#define CHRDEV_MAJOR_DYN_EXT_END 384
> +
>  extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
>  extern int register_chrdev_region(dev_t, unsigned, const char *);
>  extern int __register_chrdev(unsigned int major, unsigned int baseminor,
> 
> 
> 
> ----
> 
> This results in char devices like this (another patch might be prudent
> to fix the ordering):
> 
> Character devices:
> 510 ttySLM
>   1 mem
> 511 noz
>   4 /dev/vc/0
>   4 tty
>   4 ttyS
>   5 /dev/tty
>   5 /dev/console
>   5 /dev/ptmx
>   7 vcs
>   9 st
>  10 misc
>  13 input
>  21 sg
>  29 fb
>  43 ttyI
>  45 isdn
>  68 capi20
>  86 ch
>  90 mtd
>  99 ppdev
> 108 ppp
> 128 ptm
> 136 pts
> 152 aoechr
> 153 spi
> 161 ircomm
> 172 ttyMX
> 174 ttyMI
> 202 cpu/msr
> 203 cpu/cpuid
> 204 ttyJ
> 204 ttyMAX
> 206 osst
> 226 drm
> 235 ttyS
> 236 ttyRP
> 237 ttyARC
> 238 ttyPS
> 239 ttyIFX
> 494 rio_cm
> 240 ttySC
> 495 cros_ec
> 241 ipmidev
> 496 hidraw
> 242 rio_mport
> 497 ttySDIO
> 243 xz_dec_test
> 498 uio
> 244 bsg
> 499 firewire
> 245 pvfs2-req
> 500 nvme
> 246 watchdog
> 501 aac
> 247 iio
> 502 mei
> 248 ptp
> 503 phantom
> 249 pps
> 504 aux
> 250 dax
> 505 cmx
> 251 dimmctl
> 506 cmm
> 252 ndctl
> 507 ttySLP
> 253 tpm
> 508 ttyIPWp
> 254 gpiochip
> 509 ttySL
> 

At quick glance, ooks good to me, care to clean it up and make it behind
a config option?

thanks,

greg k-h
