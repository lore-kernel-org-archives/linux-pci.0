Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5739306764;
	Thu,  2 Jul 2026 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030739; cv=none; b=H/6OW5Wzn9iLjdFvL3cjHcAEDMzaaMpri+lJGNwP/jH+4J+/r0MRt9PzuayqvSyZ5ZHS+ooP3cSUtJD05rS4sttJhGPoHR5Vr68Ib4H4GwTevJZ1JG+AcVDIobLwMVuFhflSLQL3RgYEjiqS0hnu0exVhJntkPoYOAL2+0PtGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030739; c=relaxed/simple;
	bh=uIK2wXZt6lpexw1RHubScXDuScpKzH+Rgz4MJDFq5qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bq9uR+djqQK7ZoqxU2AgDDhqB76MFDQLs2Aq0R/A33l7Zr9cDX5SSRHDDVmNZ7R5E0QvciuVCRsuG1dTWyR0NXQtB6+7qTi5Lrs9SrEN6aZfWWBOMBlNHLd6SO8VS8HlqjNqP4FWjbflOHODXR7WnI8Yn9uslt+LCcRrXL0ArBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CREfmupk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CREfmupk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C475C1F000E9;
	Thu,  2 Jul 2026 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783030738;
	bh=uIK2wXZt6lpexw1RHubScXDuScpKzH+Rgz4MJDFq5qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CREfmupkg9nGL3Ew/EXkU+T+JQ5dKch4+F69AFVz1GLhUkftCOhcFGPBzPexsATpg
	 mQiSkKSBD25mkuLuGkKyDmZzv9I/Ro+8oHqZgvFQhJMxhSecuVGMJmDJSx4ogYFZC3
	 B2mOYGl5oqKY53a/9CJUhZ6HYNzvYlB0GhRiadeHqeHGmna98l/U9FJc2ewjiKekPw
	 O32zadvoqu44Ue+iLi3eIufTKALzVX4kdUczoVvbSQbq/rxYndz2l9HM2NvqxeQAW5
	 dTlVRvBWatCFscdttyyBGR44vNEBXE08f7/eboDUucWlsy7T53xYTmGa0ElJSEheJH
	 eVIO69EYIlprQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Marc Zyngier
 <maz@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn
 Helgaas
 <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 4/5] irqchip/gic-v3: Add Renesas R-Car Gen4 erratum
 workaround
In-Reply-To: <20260701203918.63189-5-marek.vasut+renesas@mailbox.org>
References: <20260701203918.63189-1-marek.vasut+renesas@mailbox.org>
 <20260701203918.63189-5-marek.vasut+renesas@mailbox.org>
Date: Fri, 03 Jul 2026 00:18:55 +0200
Message-ID: <87wlvdm3w0.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 01 2026 at 22:37, Marek Vasut wrote:
> Renesas R-Car S4/V4H/V4M GIC600 integration has address width for AXI
> or APB interface configured to 32 bit, it can therefore access only
> the first 4 GiB of physical address space. This information comes from
> R-Car V4H Interface Specification sheet, there is currently no technical
> update number assigned to this limitation. Further input from hardware
> engineer indicates that this limitation also applies to R-Car S4 and V4M.
> Name the limitation GEN4GICITS1, and add a driver quirk to mitigate this
> limitation.
>
> The quirk is keyed on the combination of the GIC implementation
> and the platform identification in the device tree.
>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Co-developed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Assuming this goes through the PCI tree:

Acked-by: Thomas Gleixner <tglx@kernel.org>
