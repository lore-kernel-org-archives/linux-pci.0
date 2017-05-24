Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 24 May 2017 10:44:50 +0200
From: Joerg Roedel <jroedel@suse.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: 'David Woodhouse' <dwmw2@infradead.org>,
        'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Samuel Sieb <samuel@sieb.net>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170524084450.GB12353@suse.de>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652634583ADBB2C93E1414DF70C0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <1493893297.4904.71.camel@infradead.org>
 <BN6PR12MB1652A0F240C19F2CF3304300F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BN6PR12MB1652A0F240C19F2CF3304300F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alexander,

On Tue, May 23, 2017 at 07:54:12PM +0000, Deucher, Alexander wrote:
> I finally got an answer from the hw team and we validated ATS on
> stoney as well so in theory this patch shouldn’t actually be needed.
> I think we may actually be papering over some other issue.  The
> following patch seems to also fix this issue (and other issues):
> https://www.spinics.net/lists/stable/msg172631.html

Yeah, but it still looks to me like that the hardware got into some
weird state with the storm of ATS invalidations sent to it.

The Completion-Wait loop timeouts seen in the original bug report
indicate that the IOMMU is waiting for a response that never comes. And
this is probably the ATS flush completion response from the GPU, as
disabling ATS on the GPU makes the issue disappear.

Regards,

	Joerg
