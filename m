Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983556;
	b=fx7vs2IVOA0CDKHyo2g/QJQ3zAc+lMUObiqFARFl5nnWT+eQ6jg6Og61b9CkGcTRrS+l
	 hIBTUUNNZSx14kPfyP37TItki9iPbmniauag6h6Zbzc2skJ0bVqD2JebY0Is7Ejv+cdET
	 KCXyl8SkG1YdhDDbSGHBA/dkCO2ONrhdQ5bnGD75/jlWbuoQ+XFXb5HgdstvjZaaxgvCA
	 RS9GlfUcGou522T/xhHa5bacUwL86KpGbShPMCRZbOhPqOyjyXt7jMLaSTUEzFOtv30CM
	 /sowwmJlGhDYeI9hyrLZAP0sIgqklTQFGtIkfgo34Qf0zyE8tD3bPA+8KWXqEiDlCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983556;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZtRdGixpy0AcgQaKbsyaz2VVQ0DkKxWEPl2oVAQ6i68=;
	b=2iek0+mNjURf31ZWLvKCfpQ6TSOSP7nrV2Kd4vj97Qpi9p9l66V5USYkvKXds/ZGrfiD
	 AGfpwcwR0q3SeXMI8sIafzZQi9oDUg+iwDDy0s/9WvRiACi3Fr8tJ1HRAvm7s+SyYhQdH
	 mykoM7TYJKm2cTcuWxB0Ql/3Td6HptTkWG41AvOUfGRJUpd4d064V3hgHFoXEqHGeHDD5
	 3rJeB8BrjeHGi+rtxPIeXYz6R7gtok9IbHjYzObLi8ljkB+W0kmiOK/7FKvO0NPinjh6N
	 uvU6NPbs19Ely3dGsIeAS5Yn4fggGTqEMSrk0sMLHlu+ngjH8uCpnlVLEP88YQkIBzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsLRcYtk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B31606D803
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsLRcYtk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AE21F0089F;
	Fri,  6 Nov 2026 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983556;
	bh=ZtRdGixpy0AcgQaKbsyaz2VVQ0DkKxWEPl2oVAQ6i68=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NsLRcYtkxg2l58iDqZGkr5QRSVETLJr+c1jrT11BmfEF23RaKRPdsbdPGgfCn91N6
	 22SSc6Ij5q3LkoARfG9zZfshHDm3arzM6jy0y6rKDSgt5B+v2HscSyRzPohQqS5gTa
	 1vyV779wymeJIveWlSaWkNJdSh1nJwAiHlvf2dcCxx7lvgKMlyNDnL4D3sitJYKkfd
	 3Io95SFrF8uNVIErMgiWGpft3TDGCKgILptl+JwN7/M5GtIs7a0rT0ibs7LBC6sSSK
	 63dv4ezA0IAdVQfZaq3mWJnD1fic8Tnnx1mm0mpyVeY4nw+et5UDw8CreHd+aQCX4M
	 RZrD7+PG2eGQw==
Date: Fri, 6 Nov 2026 10:45:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Poulin, Louis" <poulin.louis@student.oaklandcc.edu>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	zhaojinming@uniontech.com
Subject: Re: [RFC PATCH] PCI/ASPM: Handle missing link state in sysfs reads
Message-ID: <20261106164554.GA1630135@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGQButuh2zJ9dvNc4ioqaSh32EGChc9Z3HORr9DwnNd90=zgCg@mail.gmail.com>

On Wed, Nov 04, 2026 at 05:19:17PM -0800, Poulin, Louis wrote:
> From: Louis H. Poulin II <poulin.louis@student.oaklandcc.edu>
> 
> InputPlumber can hit a NULL pointer dereference at l0s_aspm_show()
> while reading PCIe sysfs attributes on an ASUS TUF GAMING X870-PLUS
> WIFI. The same fault was seen on downstream OGC kernels
> 7.2.9-ogc3.1.fc44 and 7.2.15-ogc1.1.fc45. The latter logged:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   RIP: 0010:l0s_aspm_show+0x47/0x80
>     dev_attr_show+0x1f/0x50
>     sysfs_kf_seq_show+0xa8/0x110
>     seq_read_iter+0x132/0x4c0
> 
> The faulting instruction reads at offset 0x30 with a NULL base
> register, consistent with accessing the ASPM state through a NULL
> link.
> 
> The visibility callback already hides the ASPM attributes when there
> is no link state, but the read callback looks up the link again. In
> the affected boot path, the read reached the callback with no link.
> A diagnostic build saw this on AMD xHCI [1022:15b7] and HD Audio
> [1022:15e3], both downstream of internal GPP bridge [1022:14dd].
> 
> Return -ENODEV from aspm_attr_show_common() when the link lookup
> returns NULL. On Helix, the equivalent guard with diagnostic logging
> ran on the downstream kernel and the host reached Game Mode on
> three repeat cold boots without the oops or an InputPlumber restart.
> 
> ZhaoJinming previously proposed NULL checks for the ASPM and clock
> power-management sysfs callbacks.
> 
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2607.3/04295.html
> Signed-off-by: Louis H. Poulin II <poulin.louis@student.oaklandcc.edu>
> ---
> The diagnostic build runs on the affected daily-use Helix system.
> The hardware results above are from the downstream OGC build.
> 
> The RFC builds and boots in an isolated x86-64 QEMU VM on mainline.
> A synthetic KUnit fixture passed for both missing and present links.
> The same fixture without the guard faulted at address 0x30 in
> aspm_attr_show_common(). This exercises the callback, while the
> physical trigger and the cause of the visibility mismatch remain
> unverified on mainline. The QEMU test called the callback directly
> and did not exercise the real sysfs read path.
> 
> In the pinned mainline tree, pcie_aspm_exit_link_state() frees the
> parent's link state only when removing link->downstream (function 0).
> Could removing function 0 leave an ASPM attribute visible on a
> surviving sibling function? The Helix traces do not establish that
> this removal path ran.
> 
> The guard handles a NULL lookup. The show callback reads the link
> without aspm_lock, so the guard alone does not establish safe link
> lifetime during concurrent removal. clkpm_show() and the store
> callbacks also dereference the link. Should the fix address group
> visibility and lifetime, or should those callbacks get separate
> guards if their paths can also be reached without a link?

See https://lore.kernel.org/all/20261105234628.GA1576767@bhelgaas

If there's a lifetime issue, e.g., an issue with concurrent removal,
we should fix that.

>  drivers/pci/pcie/aspm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b039b57..f78da8b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1716,6 +1716,9 @@ static ssize_t aspm_attr_show_common(struct device *dev,
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> 
> +	if (!link)
> +		return -ENODEV;
> +
>  	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
>  }
> 
> 
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
