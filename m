Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <547C77E0.5060607@citrix.com>
Date: Mon, 1 Dec 2014 14:14:56 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux@eikelenboom.it>
Subject: Re: [Xen-devel] [PATCH v4 7/7] xen/pciback: Restore configuration
 space when detaching from a guest.
References: <1416608271-18931-1-git-send-email-konrad.wilk@oracle.com> <1416608271-18931-8-git-send-email-konrad.wilk@oracle.com>
In-Reply-To: <1416608271-18931-8-git-send-email-konrad.wilk@oracle.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21/11/14 22:17, Konrad Rzeszutek Wilk wrote:
> The commit "xen/pciback: Don't deadlock when unbinding." was using
> the version of pci_reset_function which would lock the device lock.
> That is no good as we can dead-lock. As such we swapped to using
> the lock-less version and requiring that the callers
> of 'pcistub_put_pci_dev' take the device lock. And as such
> this bug got exposed.
> 
> Using the lock-less version is  OK, except that we tried to
> use 'pci_restore_state' after the lock-less version of
> __pci_reset_function_locked - which won't work as 'state_saved'
> is set to false. Said 'state_saved' is a toggle boolean that
> is to be used by the sequence of a) pci_save_state/pci_restore_state
> or b) pci_load_and_free_saved_state/pci_restore_state. We don't
> want to use a) as the guest might have messed up the PCI
> configuration space and we want it to revert to the state
> when the PCI device was binded to us. Therefore we pick
> b) to restore the configuration space.
> 
> We restore from our 'golden' version of PCI configuration space, when an:
>  - Device is unbinded from pciback
>  - Device is detached from a guest.
> 
> Reported-by:  Sander Eikelenboom <linux@eikelenboom.it>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  drivers/xen/xen-pciback/pci_stub.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 843a2ba..eb8b58e 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -105,7 +105,7 @@ static void pcistub_device_release(struct kref *kref)
>  	 */
>  	__pci_reset_function_locked(dev);
>  	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
> -		dev_dbg(&dev->dev, "Could not reload PCI state\n");
> +		dev_info(&dev->dev, "Could not reload PCI state\n");

Why dev_info when...

> @@ -279,9 +281,19 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
>  	 * (so it's ready for the next domain)
>  	 */
>  	device_lock_assert(&dev->dev);
> -	__pci_reset_function_locked(dev);
> -	pci_restore_state(dev);
> -
> +	dev_data = pci_get_drvdata(dev);
> +	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
> +	if (ret < 0)
> +		dev_warn(&dev->dev, "Could not reload PCI state\n");

... this one is dev_warn?

> +	else {
> +		__pci_reset_function_locked(dev);

I think the reset should always be attempted regardless of whether the
correct state was loaded or not.

David
