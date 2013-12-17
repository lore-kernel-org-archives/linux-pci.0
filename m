Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Dec 2013 11:03:22 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, ddutile@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pci: Add Virtual Channel to save/restore support
Message-ID: <20131217180322.GA12482@google.com>
References: <20131210183339.26294.14581.stgit@bling.home>
 <20131210184845.26294.81385.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131210184845.26294.81385.stgit@bling.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 10, 2013 at 11:48:45AM -0700, Alex Williamson wrote:
>...
> +	pci_read_config_dword(dev->bus->self, pos2 + PCI_VC_PORT_REG1, &reg1);
> +	evcc = reg1 & PCI_VC_REG1_EVCC;

I think PCI_VC_PORT_REG1 and PCI_VC_PORT_REG2 are mis-named and should be
changed to CAP1 and CAP2 or similar.  Almost everything here is a
"register."

Bjorn
