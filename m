Return-Path: <SRS0=Tqmx=DO=ozlabs.ru=aik@kernel.org>
Return-Path: <SRS0=Tqmx=DO=ozlabs.ru=aik@kernel.org>
Subject: Re: [PATCH v1 2/7] powerpc/kernel: Add uevents in EEH error/resume
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <79cea2a4-510d-37b5-0892-c87ffd0221b4@ozlabs.ru>
Date: Mon, 18 Dec 2017 14:54:35 +1100
MIME-Version: 1.0
In-Reply-To: <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 14/12/17 02:32, Bryant G. Ly wrote:
> Devices can go offline when EEH is reported. This patch adds
> a change to the kernel object and lets udev know of error.
> When device resumes a change is also set reporting device as
> online. Therefore, EEH events are better propagated to user
> space for devices in powerpc arch.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 3c0fa99c5533..c61bf770282b 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -204,6 +204,7 @@ static void *eeh_report_error(void *data, void *userdata)
>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>  	enum pci_ers_result rc, *res = userdata;
>  	struct pci_driver *driver;
> +	char *envp[] = {"EVENT=EEH_ERROR", "ONLINE=0", NULL};

scripts/checkpatch.pl:

WARNING: char * array declaration might be better as static const
#27: FILE: arch/powerpc/kernel/eeh_driver.c:207:
+       char *envp[] = {"EVENT=EEH_ERROR", "ONLINE=0", NULL};



>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> @@ -228,6 +229,7 @@ static void *eeh_report_error(void *data, void *userdata)
>  
>  	edev->in_error = true;
>  	eeh_pcid_put(dev);
> +	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
>  	return NULL;
>  }
>  
> @@ -358,6 +360,7 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>  	bool was_in_error;
>  	struct pci_driver *driver;
> +	char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};


WARNING: char * array declaration might be better as static const
#43: FILE: arch/powerpc/kernel/eeh_driver.c:363:
+       char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};


>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> @@ -379,8 +382,8 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	}
>  
>  	driver->err_handler->resume(dev);
> -

Unnecessary change.


>  	eeh_pcid_put(dev);
> +	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
>  	return NULL;
>  }
>  
> 


-- 
Alexey
