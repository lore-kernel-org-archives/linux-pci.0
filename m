Return-Path: <mrochs@linux.vnet.ibm.com>
Return-Path: <mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] cxl: use pcibios_free_controller_deferred() when removing vPHBs
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Thu, 18 Aug 2016 12:02:42 -0500
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        helgaas@kernel.org, mauricfo@linux.vnet.ibm.com,
        gwshan@linux.vnet.ibm.com, ruscur@russell.cc,
        ukrishn@linux.vnet.ibm.com, imunsie@au1.ibm.com,
        fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
        felix@linux.vnet.ibm.com
References: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <0170D6B7-1005-47B5-9DC7-EC55846D2DA2@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

> On Aug 18, 2016, at 2:35 AM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> When cxl removes a vPHB, it's possible that the pci_controller may be =
freed
> before all references to the devices on the vPHB have been released. =
This
> in turn causes an invalid memory access when the devices are =
eventually
> released, as pcibios_release_device() attempts to call the phb's
> release_device hook.
>=20
> In cxl_pci_vphb_remove(), remove the existing call to
> pcibios_free_controller(). Instead, use
> pcibios_free_controller_deferred() to free the pci_controller after =
all
> devices have been released. Export pci_set_host_bridge_release() so we =
can
> do this.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
