Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 30 Nov 2011 18:24:23 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Anand Kanaginhal <anand_dk@hotmail.com>
Cc: greg@kroah.com, Linux PCI mailing <linux-pci@vger.kernel.org>,
	linux kernel mailing <linux-kernel@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>
Subject: Re: PCIe Hotplugging not working
Message-ID: <20111130182423.GA4831@srcf.ucam.org>
References: <BAY163-W52E309F419E3588206D889FBB30@phx.gbl>
 <BAY163-W47DD39095DA3EB108AA3F2FBB30@phx.gbl>
 <20111130154022.GA1411@srcf.ucam.org>
 <BAY163-W80F10350D24162EFC3699FBB00@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY163-W80F10350D24162EFC3699FBB00@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 30, 2011 at 09:18:39AM -0800, Anand Kanaginhal wrote:
> 
> Hi Mathew,
> I have following options set 
> 
> CONFIG_HOTPLUG_PCI_PCIE=y
> CONFIG_HOTPLUG_PCI_ACPI=m

Please try with this built in, not as a module. What kind of board are 
you using?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
