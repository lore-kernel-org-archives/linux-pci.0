Return-Path: <SRS0=B+Ju=IS=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=B+Ju=IS=rock-chips.com=shawn.lin@kernel.org>
Cc: linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Native PCI host controller patches
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20180530162610.GF39853@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <7bc243ff-a950-a7ce-a337-87348eb4b324@rock-chips.com>
Date: Thu, 31 May 2018 09:26:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180530162610.GF39853@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2018/5/31 0:26, Bjorn Helgaas wrote:
> Lorenzo will be out until mid-June, so if you have urgent patches that
> he would normally handle (drivers/pci/{host,dwc,endpoint}/*), let me
> know.
> 

In early discussion and off-list talk with Lorenzo, we wants a second
pull request for renaming the directories for drivers which would be
beneficial to future submit but not bother previous in-flight patches to
do rebase. I sent a patch[1] for that a moment ago, please let me know
if you'd like to merge it on the top of your final PR for v4.18 merge
window.

Thanks for your time!

[1]http://patchwork.ozlabs.org/patch/923097/

> I don't have time to review and merge everything, but if you have
> something that really needs to be merged for v4.17 or during the v4.18
> merge window, point it out to me and make a case for squeezing it in,
> and I'll try to work it in.
> 
> Bjorn
> 
> 
> 
