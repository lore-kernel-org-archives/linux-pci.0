Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36088 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbLJXLZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2015 18:11:25 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] drivers:pci:hotplug Fix all space prohibited before that ,
From: sasa bogicevic <brutallesale@gmail.com>
In-Reply-To: <20151210224700.GD367@localhost>
Date: Fri, 11 Dec 2015 00:11:20 +0100
Cc: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <23CC472C-B114-4590-A677-7FDCCC9F6B93@gmail.com>
References: <1449744040-76428-1-git-send-email-brutallesale@gmail.com> <20151210224700.GD367@localhost>
To: Bjorn Helgaas <helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ha just found the lines when I removed the -l flag

drivers/pci/hotplug/shpchp_ctrl.c:	ctrl_dbg(ctrl, "%s: p_slot->device, slot_offset, hp_slot = %d, %d ,%d\n",
drivers/pci/hotplug/cpqphp_ctrl.c:	dbg("%s: func->device, slot_offset, hp_slot = %d, %d ,%d\n",

So there are spaces before that “%d” but checkpatch.pl didn’t complain 

{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Dec 10, 2015, at 23:47, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Thu, Dec 10, 2015 at 02:40:40AM -0800, Bogicevic Sasa wrote:
>> This fixes all checkpatch errors about space prohibited
>> before comma in drivers/pci/hotplug folder
> 
> What happened?  I was hoping for a patch that fixed everything in
> drivers/pci at once, but even after this patch, I see this:
> 
>  $ grep -rl " ," drivers/pci/
>  drivers/pci/host/pci-imx6.c
>  drivers/pci/hotplug/cpqphp.h
>  drivers/pci/hotplug/ibmphp_core.c
>  drivers/pci/hotplug/shpchp.h
>  drivers/pci/hotplug/pciehp.h
>  drivers/pci/hotplug/rpaphp.h
>  drivers/pci/hotplug/cpqphp_ctrl.c
>  drivers/pci/hotplug/ibmphp.h
>  drivers/pci/hotplug/shpchp_ctrl.c
> 
> 
>> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
>> ---
>> drivers/pci/hotplug/acpi_pcihp.c        | 8 ++++----
>> drivers/pci/hotplug/cpci_hotplug_core.c | 8 ++++----
>> drivers/pci/hotplug/cpci_hotplug_pci.c  | 8 ++++----
>> drivers/pci/hotplug/cpcihp_generic.c    | 8 ++++----
>> drivers/pci/hotplug/cpcihp_zt5550.c     | 8 ++++----
>> drivers/pci/hotplug/ibmphp_ebda.c       | 2 +-
>> drivers/pci/hotplug/pci_hotplug_core.c  | 8 ++++----
>> drivers/pci/hotplug/pcihp_skeleton.c    | 8 ++++----
>> 8 files changed, 29 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
>> index 876ccc6..80d94d2 100644
>> --- a/drivers/pci/hotplug/acpi_pcihp.c
>> +++ b/drivers/pci/hotplug/acpi_pcihp.c
>> @@ -36,10 +36,10 @@
>> 
>> #define MY_NAME	"acpi_pcihp"
>> 
>> -#define dbg(fmt, arg...) do { if (debug_acpi) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __func__ , ## arg); } while (0)
>> -#define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
>> -#define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
>> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
>> +#define dbg(fmt, arg...) do { if (debug_acpi) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __func__, ## arg); } while (0)
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
>> 
>> #define	METHOD_NAME__SUN	"_SUN"
>> #define	METHOD_NAME_OSHP	"OSHP"
>> diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
>> index 46db293..1c59e4b 100644
>> --- a/drivers/pci/hotplug/cpci_hotplug_core.c
>> +++ b/drivers/pci/hotplug/cpci_hotplug_core.c
>> @@ -46,11 +46,11 @@
>> 	do {							\
>> 		if (cpci_debug)					\
>> 			printk (KERN_DEBUG "%s: " format "\n",	\
>> -				MY_NAME , ## arg);		\
>> +				MY_NAME, ## arg);		\
>> 	} while (0)
>> -#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
>> -#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
>> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
>> 
>> /* local variables */
>> static DECLARE_RWSEM(list_rwsem);
>> diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
>> index 788db48..f2d3f4f 100644
>> --- a/drivers/pci/hotplug/cpci_hotplug_pci.c
>> +++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
>> @@ -39,11 +39,11 @@ extern int cpci_debug;
>> 	do {							\
>> 		if (cpci_debug)					\
>> 			printk (KERN_DEBUG "%s: " format "\n",	\
>> -				MY_NAME , ## arg);		\
>> +				MY_NAME, ## arg);		\
>> 	} while (0)
>> -#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
>> -#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
>> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
>> 
>> 
>> u8 cpci_get_attention_status(struct slot *slot)
>> diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
>> index 66b7bbe..d0ab4e1 100644
>> --- a/drivers/pci/hotplug/cpcihp_generic.c
>> +++ b/drivers/pci/hotplug/cpcihp_generic.c
>> @@ -55,11 +55,11 @@
>> 	do {							\
>> 		if (debug)					\
>> 			printk (KERN_DEBUG "%s: " format "\n",	\
>> -				MY_NAME , ## arg);		\
>> +				MY_NAME, ## arg);		\
>> 	} while (0)
>> -#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
>> -#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
>> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
>> 
>> /* local variables */
>> static bool debug;
>> diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
>> index 7ecf34e..80dd418 100644
>> --- a/drivers/pci/hotplug/cpcihp_zt5550.c
>> +++ b/drivers/pci/hotplug/cpcihp_zt5550.c
>> @@ -50,11 +50,11 @@
>> 	do {							\
>> 		if (debug)					\
>> 			printk (KERN_DEBUG "%s: " format "\n",	\
>> -				MY_NAME , ## arg);		\
>> +				MY_NAME, ## arg);		\
>> 	} while (0)
>> -#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
>> -#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
>> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
>> 
>> /* local variables */
>> static bool debug;
>> diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
>> index d9b197d..8a77275 100644
>> --- a/drivers/pci/hotplug/ibmphp_ebda.c
>> +++ b/drivers/pci/hotplug/ibmphp_ebda.c
>> @@ -177,7 +177,7 @@ static void __init print_ebda_pci_rsrc (void)
>> 
>> 	list_for_each_entry(ptr, &ibmphp_ebda_pci_rsrc_head, ebda_pci_rsrc_list) {
>> 		debug ("%s - rsrc type: %x bus#: %x dev_func: %x start addr: %x end addr: %x\n",
>> -			__func__, ptr->rsrc_type ,ptr->bus_num, ptr->dev_fun,ptr->start_addr, ptr->end_addr);
>> +			__func__, ptr->rsrc_type,ptr->bus_num, ptr->dev_fun,ptr->start_addr, ptr->end_addr);
>> 	}
>> }
>> 
>> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
>> index d1fab97..2bac1b9 100644
>> --- a/drivers/pci/hotplug/pci_hotplug_core.c
>> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
>> @@ -45,10 +45,10 @@
>> 
>> #define MY_NAME	"pci_hotplug"
>> 
>> -#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __func__ , ## arg); } while (0)
>> -#define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
>> -#define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
>> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
>> +#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __func__, ## arg); } while (0)
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
>> 
>> 
>> /* local variables */
>> diff --git a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
>> index d062c00..14b5d10 100644
>> --- a/drivers/pci/hotplug/pcihp_skeleton.c
>> +++ b/drivers/pci/hotplug/pcihp_skeleton.c
>> @@ -52,11 +52,11 @@ static LIST_HEAD(slot_list);
>> 	do {							\
>> 		if (debug)					\
>> 			printk(KERN_DEBUG "%s: " format "\n",	\
>> -				MY_NAME , ## arg);		\
>> +				MY_NAME, ## arg);		\
>> 	} while (0)
>> -#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
>> -#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
>> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
>> 
>> /* local variables */
>> static bool debug;
>> -- 
>> 2.5.0
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

