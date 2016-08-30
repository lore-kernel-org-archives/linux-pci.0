Return-Path: <andrew.donnellan@au1.ibm.com>
Return-Path: <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] cxl: use pcibios_free_controller_deferred() when removing
 vPHBs
To: linuxppc-dev@lists.ozlabs.org
References: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Cc: clombard@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
        mrochs@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
        fbarrat@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com,
        helgaas@kernel.org, imunsie@au1.ibm.com, felix@linux.vnet.ibm.com,
        ukrishn@linux.vnet.ibm.com, stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 30 Aug 2016 11:58:44 +1000
MIME-Version: 1.0
In-Reply-To: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3049096a-97ea-9549-ee29-ae937708cf45@au1.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Hi stable team,

The following patch, which ended up upstream as 
6f38a8b9a45833495dc878c335c5431cd98a16ed:

On 18/08/16 17:35, Andrew Donnellan wrote:
> When cxl removes a vPHB, it's possible that the pci_controller may be freed
> before all references to the devices on the vPHB have been released. This
> in turn causes an invalid memory access when the devices are eventually
> released, as pcibios_release_device() attempts to call the phb's
> release_device hook.
>
> In cxl_pci_vphb_remove(), remove the existing call to
> pcibios_free_controller(). Instead, use
> pcibios_free_controller_deferred() to free the pci_controller after all
> devices have been released. Export pci_set_host_bridge_release() so we can
> do this.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> This patch requires http://patchwork.ozlabs.org/patch/658324/. It should go
> through the powerpc tree.

This depends on 2dd9c11b9d4dfbd6c070eab7b81197f65e82f1a0 which didn't 
end up being tagged as cc: stable. It also ended up being applied in the 
wrong order in the powerpc/fixes tree...


Thanks,
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
