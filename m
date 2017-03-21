Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 22 Mar 2017 10:46:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Bodong Wang <bodong@mellanox.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        saeedm@mellanox.com, Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH] pci/sriov: Add an option to probe VFs or not before
 enabling SR-IOV
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1490022874-54718-1-git-send-email-bodong@mellanox.com>
 <20170320230706.GA12252@gwshan>
 <7bfcfdcd-e0a8-f1e9-f112-fa35fdb845d7@mellanox.com>
 <20170320225708.6868676a@t450s.home>
 <20170321054305.GA12230@gwshan>
 <20170321000158.444991a3@t450s.home>
 <20170321092518.GA19657@gwshan>
 <20170321082329.4f408a9e@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321082329.4f408a9e@t450s.home>
Message-Id: <20170321234636.GA3972@gwshan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 21, 2017 at 08:23:29AM -0600, Alex Williamson wrote:
>On Tue, 21 Mar 2017 20:25:18 +1100
>Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> On Tue, Mar 21, 2017 at 12:01:58AM -0600, Alex Williamson wrote:
>> >On Tue, 21 Mar 2017 16:43:05 +1100
>> >Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:  
>> >> On Mon, Mar 20, 2017 at 10:57:08PM -0600, Alex Williamson wrote:  
>> >> >On Mon, 20 Mar 2017 18:34:23 -0500
>> >> >Bodong Wang <bodong@mellanox.com> wrote:    
>> >> 
>> >> .../...
>> >>   
>> >> >> > Bodong, I'm not sure if there is a requirement to load driver for the
>> >> >> > specified number of VFs? That indicates no driver will be loaded for
>> >> >> > other VFs. If so, this interface might serve the purpose as well.      
>> >> >> Gavin, thanks for the review. That is indeed an interesting suggestion. 
>> >> >> Theoretically,  we can change that probe_vfs from boolean to integer. 
>> >> >> And use it as a counter to probe the first N VFs(if N < total_vfs).  
>> >> >> Let's see if there are any objections.    
>> >> >
>> >> >Is it just me or does this seem like a confusing user interface, ie. to
>> >> >get binary on/off behavior a user now needs to 'cat total_vfs >
>> >> >sriov_probe_vfs'.  It's not very intuitive, what's the use case for it?
>> >> >    
>> >> 
>> >> After it's changed to integer, it accepts number. If users want to load
>> >> driver for all VFs and don't want to check the maximal number of VFs,
>> >> they can simply write 0xffffffff. So "on" and "off" are replaced with 0xffffffff
>> >> and 0, but users has to press the keyboard more times though.
>> >> 
>> >> drivers/net/ethernet/mellanox/mlx4/main.c::probe_vfs_argc allows to specify
>> >> the number of VFs with which we're going to bind drivers. Less time is needed
>> >> to enable SRIOV capability. As I had in some development environment: assume
>> >> PF supports 256 VFs and I'm going to enable all of them, but I only want to
>> >> load driver for two of them, then test the data path on those two VFs. Besides,
>> >> I can image the VF needn't a driver in host if it's going to be passed to guest. 
>> >> Not sure how much sense it makes.  
>> >
>> >Yes, I understand what you're trying to do, but I still think it's
>> >confusing for a user interface.  This also doesn't answer what's the
>> >practical, typical user case you see where it's useful to probe some
>> >VFs but not others.  The case listed is a development case where you
>> >could just as easily disable all probing, then manually bind the first
>> >two VFs to the host driver.  Which is the better design, impose a
>> >confusing interface on all users to simplify an obscure development
>> >environment or simplify the user interface and assume developers know
>> >how to bind devices otherwise?  Thanks,
>> >  
>> 
>> Yeah, your explanation is also fairly reasonable. The interface has
>> been named as "probe_vfs" instead of "probe_vf" or "probe_vf_driver".
>> So it seems it should accept number of VFs on which drivers are loaded.
>> Besides, making this interface accept number corresponds to 3 possiblities:
>> all, none and load drivers on part of available VFs. So more flexibility
>> is gained.
>> 
>> User can theoritically have the use case as I had - passing through
>> some of the VFs to guest: (A) All VFs are bound with drivers; (B) unbind
>> the drivers for some of the VFs; (C) bind the VFs with vfio-pci; (D) passing
>> through; (A) is overhead in this scenario. Some CPU cycles are saved if (A)
>> is avoided.
>
>Huh?  I'm asking what the practical and typical use case is for this
>and you're rehashing the name of the interface and giving me
>theoretical examples.  Outside of your development environment, why
>would a user every actually want to do this?
>

Frankly, I'm not sure how much sense it has as I mentioned from the
beginning. I knew mlx4 driver supports it and it's why I asked.

>If we want to talk about the ABI, I would suggest drawing from existing
>ABIs.  We already have drivers_autoprobe as part of the standard sysfs
>ABI, so if we want a binary switch, then sriov_drivers_autoprobe might
>be a logical choice.  If you're concerned about this mythical overhead
>of binding to one driver then another, then why not draw from the
>driver_override interface to allow the user to specify the driver to
>bind to, perhaps sriov_driver_override.  Then if the user wants to bind
>all the devices to vfio-pci, they can do so easily.  I still fail to
>see that probing some fixed number of the VFs and leaving the rest
>unprobed has any practical value and I imagine bugs coming in because
>users are confused why some of their VFs behave differently than
>others.  Thanks,
>

Ok. I tend to agree with you - the use case isn't practical. On the other
hand, I think "sriov_driver_orverride" would be a good idea, but it's not
too much related to this patch. Thank you for the explanation.

Thanks,
Gavin
