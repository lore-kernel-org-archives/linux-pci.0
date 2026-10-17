Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F954779;
	Sat, 17 Oct 2026 05:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214328; cv=none; b=Ap1VVo7mm5NkCviNrcfn2pMsrOYg+ETyQGAMPsVRYTD0ESguMB9Yyme1HlpGsWLH7LXtGc5zO1PXOeIlBvpSBJKX8aHlmqQPe04E1uDgPU/VQ/ae5jZnHicHuHE+GV0Fpns9nMuxYFqYq65y47rlYntmDSubFanhN9YbFJcjFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214328; c=relaxed/simple;
	bh=dr8pAMxePn0Jof9OYf3cXdJRUpUe4jdFvbUvrFr8ufs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUHDQDDu5rEDDrJgB5eBj/NbJuD7qdTdiW7zPM9U6VlxJNVVzTBrEIazs1z+uGLEzg1P+jvlnE8XAs9kU9mLnF0VmMZYvPvpGTKKyAhGhRdEJxrdr7UBW+mNmY8V4i3UysWs86e6zhbKLqNq0NX6PivhiNUBpgMiH+/nwbeGYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QirN5LD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QirN5LD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D511F000C4;
	Sat, 17 Oct 2026 05:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792214327;
	bh=CNJmpnj/caGwbBm2YZydbNia9OHg0XdV0fyYnc3Zc9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QirN5LD14kJ7+DnEXdB4OCHZJL1raG3Ta4QKjmX/7UVwv/eMDGo8fU6nSzVWgBLg2
	 NTOKWJKaJ+sLnQrfdGeuZdP2heDkabtnByyGcYUkEz/pAcfdDiI+l6AAryg1RZrF54
	 3ExXFjP64Yrl5QlB3w82P8tpljUytdeZjPnbc+s/U/cIav57srWnH7wfwYFPGfoe9h
	 7XiphvMhH4FkeeWVWFdwQAcHgWgKlZocUNbFPfflnKR8BF5tguze7vn8458wf0jb7t
	 DZdf0Scyu33xervAOM/E1/R+LwhFZ6MAVFCej0igVqf66qe11+GuugiO1YMqx80w9A
	 Rh5DciTdrf3dQ==
Date: Sat, 17 Oct 2026 10:48:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Koichiro Den <den@valinux.co.jp>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5] PCI: rcar-gen4: Add missing PM ops
Message-ID: <atMEOFH8isshAwN8@debian>
References: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>

On Sun, Oct 04, 2026 at 03:18:13AM +0200, Marek Vasut wrote:
> The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
> and V4H, this is an always-on power domain which is not shut down in
> suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
> which is shut down during suspend, and the controller loses state,
> which prevents the PCIe from working after resume.
> 
> Fix this by adding generic suspend/resume noirq ops for the controller,
> which tear the link down on suspend, and restart it on resume. Use the
> same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
> PCIe link on V4H and S4 too.
> 

In the future, if any one of your Endpoint didn't allow the link to enter L2,
then you need to set the 'suspend_poweroff' flag for V4M or other SoCs which
pulls the plug during suspend:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=f845c1e2d2d4506802244ea2a378ae7b04e90bfe

> Test case which demonstrates the problem on R-Car V4M:
> "
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
> $ echo s2idle > /sys/power/mem_sleep
> $ echo platform > /sys/power/pm_test
> $ echo mem > /sys/power/state
> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
> $ diff -Naru /tmp/pre /tmp/post
> ...
> -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
> +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
>                                           ^^^^^
>                                     Class 0604->00ff
> "
> 
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")

Note that I changed this fixes tag to below while applying:
Fixes: 0270dbe4f891 ("arm64: dts: renesas: r8a779h0: Add PCIe Host and Endpoint nodes")

to reflect the fact that the V4M support is what caused the issue, not the
initial driver support.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
