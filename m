Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5546E240.5090403@hp.com>
Date: Mon, 04 May 2015 11:06:40 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
To: Baoquan He <bhe@redhat.com>
CC: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com,
	tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org,
	joro@8bytes.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, lisa.mitchell@hp.com,
	jerry.hoemann@hp.com, iommu@lists.linux-foundation.org,
	ddutile@redhat.com, doug.hatch@hp.com,
	ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com,
	dyoung@redhat.com, vgoyal@redhat.com
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com> <20150429112024.GB5799@dhcp-16-116.nay.redhat.com> <20150503085530.GK15033@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150503085530.GK15033@dhcp-16-116.nay.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi baoquan,
Could you paste the kernel log of the first kernel ?

Thanks
Zhenhua
On 05/03/2015 04:55 PM, Baoquan He wrote:
> On 04/29/15 at 07:20pm, Baoquan He wrote:
>> Bad news, I rebuilt a kernel with your patchset on 4.0.0+ (this commit
>> f614c81). Now dmar fault is  seen again.
>>
>> The lspci log and kdump log are attached, please check:
>
> I found the lspci log previously attached is emtyp, resend it again.
>
>

