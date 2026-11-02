Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619504;
	b=vjEn9K/TJxgtEx1qlNNhGTmsUcVpDHVx/aM1NvvGn1QSsucb0cbXdv44ztkPpgSSdcA8
	 NCGLXAghN4qoBBzXbZVQf6zIMsxD5XtUZrv+RBucnRwIKPPkSM+z5Zsqq8vCNwpvPPYM5
	 lq3Tsn17jf+ah7AKFQRCGptaM05ajpra3g7kxHUBfI7ViTNh7YmKWJtFYMXQb1IApzjaQ
	 cZPN3klPQfGGZLsReqhitUzE6J9p8BVz82q8jWCPgD107xKM2Ok1n82ZpUotypQHy0Ftp
	 xhJ7JTPAEk4g4jgKQGwdmXhJvOvALWw1rD+K7NI7AczR2iTcto1OBOdLOABLISO5rAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619504;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hjt2YeZX4lDDipyIlp+O5Nhf55A6rK759tPEqhL7K8o=;
	b=Lg00wdH+S/tDDmYQaCX/SHR7XSWUCv+9NzUnBBuJm55em9D1eN1KcXaum1rjqovb6eif
	 VOt5i7NUchk1mPrR1ObLgUaPuyfk2d/7cLnHAO/OJEmDdgBSuUZWtUh2sO4DdAkkmiZGE
	 cpGKCnTWUpBs3B/OIuMSN/uoGtBDDluNnP398BbF81z+sr6KjQvCODBRnQjDzSMIcyvnU
	 B0d88hK0us6G2SYxq6Xe0nZ1EYk+thRzWa5SbdmLl+h2LnzZrh0evBnFJmu6wW5TD+Cpj
	 j3wGIIe20IxCNl5DdjQvBd7qrRO3xvqrYOaJV4qXPLOemEiyu6130b3j2ygWFH5tniQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ibbs1kEV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E26606A333
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ibbs1kEV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B771F00A1C;
	Mon,  2 Nov 2026 11:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619504;
	bh=hjt2YeZX4lDDipyIlp+O5Nhf55A6rK759tPEqhL7K8o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ibbs1kEV0iYcRg1XIWuz6WhhSDrPOO8jyhwkAgWbkjxtPTJjcb5tctPlJ4TZ/J4QB
	 x+v6cVvdPRGVYJagQOHYR+zx89CMh/M7s3DRfoBu7me65YBSoe6P0NJArTHN5YIIxD
	 5Xynu73y+2LhilexrDGfrgGuJx+KbAvqKKoViEVnW5qs/wvqm+aO2quu8r/6kQfCk1
	 A3H3dVPdM7AVMl9Vg8D1CfJ65cClKcVv1Qx1gkWsfpfXbh+gQ+Mx7fVmbFLBHJ5pKY
	 4dIcZg2SiXEAoSq3SUI5YIbfpHsMzwU9Pn6C2FE9IBSaDiiDcA2Y7PQrklM6Ry+QKi
	 65h3ceExPucxQ==
Message-ID: <sashiko-outbox-193340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] PCI: tegra194: Notify Endpoint functions on
 PERST# assert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102111450.4010818-4-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
 <20261102111450.4010818-4-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:38:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI: tegra194: missing IRQ sync in pex_ep_event_pex_rst_assert()
- [High] PCI: tegra194: deadlock between pex_ep_event_pex_rst_assert() and =
pci_epc_stop()
--

commit 9fcf1c9f540e3e347bfaf4edb431bb510324fd09
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>

PCI: tegra194: Notify Endpoint functions on PERST# assert

This commit calls pci_epc_linkdown() from pex_ep_event_pex_rst_assert()
before powering down the Tegra194 PCIe endpoint controller on PERST#
assertion so endpoint function drivers can stop outstanding work.

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index 8cb907dbf6356..8dede9531956d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1704,6 +1704,9 @@ static void pex_ep_event_pex_rst_assert(struct tegr=
a_pcie_dw *pcie)
>  	if (ret)
>  		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret=
);
> =20
> +	/* Avoid the DBI register reinitialization in dw_pcie_ep_linkdown(). */
> +	pci_epc_linkdown(pcie->pci.ep.epc);

[Severity: High]
Can calling pci_epc_linkdown() here race with a pending or running
tegra_pcie_ep_irq_thread() on pcie->pci.pp.irq?

In endpoint mode, tegra_pcie_ep_hard_irq() and tegra_pcie_ep_irq_thread()
run on pcie->pci.pp.irq, while tegra_pcie_ep_pex_rst_irq() runs on the
separate GPIO interrupt pcie->pex_rst_irq:

drivers/pci/controller/dwc/pcie-tegra194.c:tegra_pcie_ep_hard_irq() {
	...
			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
				dev_dbg(pcie->dev, "Link is up with Host\n");
				set_bit(0, &pcie->link_status);
				return IRQ_WAKE_THREAD;
			}
	...
}

drivers/pci/controller/dwc/pcie-tegra194.c:tegra_pcie_ep_irq_thread() {
	...
	if (test_and_clear_bit(0, &pcie->link_status))
		dw_pcie_ep_linkup(ep);

	tegra_pcie_icc_set(pcie);
	...
}

If tegra_pcie_ep_hard_irq() fires just before PERST# assertion (or before
APPL_CTRL_LTSSM_EN is cleared), sets bit 0 in pcie->link_status, and wakes
tegra_pcie_ep_irq_thread(), pex_ep_event_pex_rst_assert() calls
pci_epc_linkdown() without disabling LTSSM or controller interrupts first,
without calling synchronize_irq(pcie->pci.pp.irq), and without clearing
bit 0 of pcie->link_status.

Wouldn't tegra_pcie_ep_irq_thread() then observe bit 0 set in
pcie->link_status and call dw_pcie_ep_linkup() -> pci_epc_linkup() after
pci_epc_linkdown() has already returned, re-arming endpoint function
workers (such as epf_test->cmd_handler) right before the controller is
powered down, as well as reading DBI registers in tegra_pcie_icc_set()
while pex_ep_event_pex_rst_assert() asserts resets and disables clocks?

[Severity: High]
Also, could calling pci_epc_linkdown() inside the pex_rst_irq threaded
handler deadlock against pci_epc_stop()?

When userspace stops the endpoint controller through configfs,
pci_epc_start_store() -> pci_epc_stop() holds epc->lock across
epc->ops->stop(epc):

drivers/pci/endpoint/pci-epc-core.c:pci_epc_stop() {
	...
	mutex_lock(&epc->lock);
	epc->ops->stop(epc);
	mutex_unlock(&epc->lock);
}

And epc->ops->stop() calls dw_pcie_ep_stop() -> dw_pcie_stop_link() ->
tegra_pcie_dw_stop_link(), which waits for the pex_rst_irq handler to
finish:

drivers/pci/controller/dwc/pcie-tegra194.c:tegra_pcie_dw_stop_link() {
	struct tegra_pcie_dw *pcie =3D to_tegra_pcie(pci);

	if (pcie->of_data->mode =3D=3D DW_PCIE_EP_TYPE)
		disable_irq(pcie->pex_rst_irq);
}

Meanwhile, if tegra_pcie_ep_pex_rst_irq() -> pex_ep_event_pex_rst_assert()
is running concurrently and calls pci_epc_linkdown(), endpoint function
link_down callbacks can synchronously wait on or invoke operations that
acquire epc->lock. For example, pci_epf_test_link_down() calls:

drivers/pci/endpoint/functions/pci-epf-test.c:pci_epf_test_link_down() {
	...
	cancel_delayed_work_sync(&epf_test->cmd_handler);
	...
}

while pci_epf_test_cmd_handler() calls pci_epc_map_addr(),
pci_epc_unmap_addr(), pci_epc_raise_irq(), and pci_epc_set_bar(), all of
which take mutex_lock(&epc->lock) (and pci_epf_mhi_link_down() directly
calls mhi_ep_power_down() -> mhi_ep_abort_transfer() ->
mhi_ep_free_host_cfg() -> pci_epf_mhi_unmap_free() ->
pci_epc_unmap_addr()).

Doesn't this create a lock inversion between epc->lock and
disable_irq(pcie->pex_rst_irq)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102111450.4010=
818-1-mmaddireddy@nvidia.com?part=3D3
