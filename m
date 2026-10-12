Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B490476681;
	Mon, 12 Oct 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816290; cv=none; b=eN8xzrMd+HNeRyeSKv3DFstHE7QO+rchDSl5pWLSQd0ea8LAQ45waNqNR5x17xZ28Eo14VP0hg5mSJyP0OJC0xlnL6YbkZmEb36PXbZqgNqFkfrQg1NAeQ7XVSD8DeokNtrregDZN5h/iAFiSl7WNLfnfXhh40JMuNNLEkKwoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816290; c=relaxed/simple;
	bh=2uUq+ZtC/cdtddN4JJ6UvSmEoku/xe9QR+7CNt+e1Rg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=umQPiApELEKBuSeUA2AAkK+jYA8woAV7JUfZtJuOAxtNQZaYpma04g5Mgi2VRddVPtNpnsbuAXdCPRKc7Z/rlbgSMeFZQNWAHBhjx0+vHLgLGhqE4ODkUQy6Xg4ZmRDYGLoxFvHkWq113h/ZvwJBDdLCoOq5OE2HEe73smSMGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4KeW1gV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4KeW1gV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5A31F0089B;
	Mon, 12 Oct 2026 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816289;
	bh=zB2KWp1GkiZ64tse1ghCOBaYf9GFmHZKAMTLzLoUfxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4KeW1gVSaF7qnT5ZCZMuk6r5NYQZD6Z1qRXyX6Wl/V2VCxsHgQt4IqRVfagdjCnO
	 yf0sKo/teRK4r0ce+BJndC9WECoKtgm8/+3f7UZCoBm7IxeAhnrydHKA1/HmXcgUDe
	 Pv2XvT7k/ZSgoVltasQEp53utEgoKeVw6akg+9CDYU6YidhLoSaLQeTJ9DviLkLX2r
	 08cK9TOhH1Qou9BplNzFmt0jPVPA4F1boTjYNv4EDjj3SSJm+7NU/A0vg22o0E2hT8
	 2Unjh+8UMBkzYToe9tlqvW5dcH8uGg8ar0w+D5Px8EEeuB4pq/JBDSOuP7LTACtZAq
	 DCeJ46U8hzgDA==
Message-ID: <sashiko-outbox-168281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/10] PCI: of: Set fwnode device of newly created
 PCI device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-gpio@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261012142826.159178-9-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:44:48 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] base: TOCTOU data race and UAF on fwnode->dev access
--

commit dc94be607770b564614555ac56ea83f070fa3dd4
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Set fwnode device of newly created PCI device nodes

Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
nodes are created and filled based on PCI core information but the
fwnode device field is not set.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 29b63a9090ae3..8914bfa25dc11 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -736,6 +736,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
> =20
> +	fw_devlink_set_device(&np->fwnode, NULL);

[Severity: High]
Does this locklessly clear the fwnode device while another traversal might =
be
reading it?

If a PCI device is concurrently removed while a driver is being bound to
another device on the same system, of_pci_remove_node() clears fwnode->dev
locklessly here.

Concurrently, __fw_devlink_pickup_dangling_consumers() in drivers/base/core=
.c
can traverse the fwnode tree and read it locklessly:

	if (fwnode->dev && fwnode->dev->bus)
		return;

Can this lead to a NULL pointer dereference if the compiler emits two loads
and the pointer is cleared in between?

Can this also cause a use-after-free if the pointer is read, then the device
is concurrently unregistered and freed before the bus field is accessed, as
no reference count is held during the lockless read?

>  	device_remove_of_node(&pdev->dev);
>  	of_changeset_revert(np->data);
>  	of_changeset_destroy(np->data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D8
