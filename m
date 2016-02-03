Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37421 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933801AbcBCV3S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 16:29:18 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] drivers:pci Add pcie/Kconfig to pci/Kconfig
From: sasa bogicevic <brutallesale@gmail.com>
In-Reply-To: <20160119033153.GE14080@localhost>
Date: Wed, 3 Feb 2016 22:29:15 +0100
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <41CC00C3-DE29-4D70-A997-C4AEE0154CF7@gmail.com>
References: <1452608545-32242-1-git-send-email-brutallesale@gmail.com> <20160119033153.GE14080@localhost>
To: Bjorn Helgaas <helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
I just sent a patch regarding pcie Kconfig in arch/ . I just wanted to ask how did you get these errors you pasted:

>  drivers/pci/pcie/Kconfig:61:warning: choice value used outside its choice group
>  drivers/pci/pcie/Kconfig:67:warning: choice value used outside its choice group
>  drivers/pci/pcie/Kconfig:74:warning: choice value used outside its choice group


Is there a tool for this ? I just wanted to be better at debugging kernel compilation process.

Thanks, Sasa
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Jan 19, 2016, at 04:31, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> Hi Bogicevic,
> 
> On Tue, Jan 12, 2016 at 06:22:25AM -0800, Bogicevic Sasa wrote:
>> Architectures currently have to include both
>> drivers/pci/Kconfig and drivers/pci/pcie/Kconfig.
>> They should include only drivers/pci/Kconfig, and
>> that should handle PCIe as well.
>> 
>> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
>> ---
>> drivers/pci/Kconfig | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 73de4ef..005dd7d 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -119,3 +119,5 @@ config PCI_LABEL
>> 	select NLS
>> 
>> source "drivers/pci/host/Kconfig"
>> +
>> +source "drivers/pci/pcie/Kconfig"
> 
> This project is something I'd like to get done, but it requires a
> little more work.  If it were this simple, I would have done it long
> ago :)
> 
> For one thing, we need to update all the Kconfig files that already
> include drivers/pci/pcie/Kconfig at the same time.  On x86,
> arch/x86/Kconfig already includes both:
> 
>  source "drivers/pci/pcie/Kconfig"
>  source "drivers/pci/Kconfig"
> 
> With your patch applied, I see these new warnings:
> 
>  05:42:09 ~/linux (wip/bogicevic-kconfig)$ make menuconfig
>  ...
>  scripts/kconfig/mconf  Kconfig
>  drivers/pci/pcie/Kconfig:61:warning: choice value used outside its choice group
>  drivers/pci/pcie/Kconfig:67:warning: choice value used outside its choice group
>  drivers/pci/pcie/Kconfig:74:warning: choice value used outside its choice group
> 
> I see that you did verify that removing the source line from
> arch/x86/Kconfig does the right thing.  We need to put all the related
> changes in a single patch so it is self-contained.  The tree should be
> buildable and functional at every stage.
> 
> Bjorn

