Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Mar 2017 22:56:16 +0200
From: 'Joerg Roedel' <jroedel@suse.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: 'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: Re: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Message-ID: <20170328205616.GR8329@suse.de>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652414344196BA60520B828F7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328202844.GQ8329@suse.de>
 <BN6PR12MB16527AD3EF2DDA863957B87EF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BN6PR12MB16527AD3EF2DDA863957B87EF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 28, 2017 at 08:37:01PM +0000, Deucher, Alexander wrote:
> The question is, could the problem stem from flushing an entity that
> didn't request it, or should that not matter?  I guess it shouldn't
> matter otherwise we'd see this on other platforms like Carrizo as
> well.

What do you mean by "didn't request it"? The IOMMU driver only sends
io/tlb invalidations to devices it enabled ATS on.



	Joerg
