Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793395603;
	b=CmuxLWWd8eSaIxBls5HYzUMbeK6W9mLGwz6EnPqn3sH5b0PsrKXCxKREP+I5NpSpfexH
	 Ubd6r60zoSs7+2RhAKlxybi9Ux3/L1jVCzXbYc9xuzVGm8doXusUjQpQCQy+T/POvY539
	 kdKPmUxHrdytQUqK2W4sd/erlI3GxVLb/6shhktvh0qbE05MTI13dQ+r3jaxN9md4YNwh
	 QFsMCMfjWad8fzKKiozGIXGyp/O+/WXV4Ew3An3ZjM/+g1yjvoUL5s8GqClCo0fzi4fV+
	 ZBRtAXD8FikIQ5e0fOv01mR5PyZ/hUFI3U/UzTNGODkYKuZqMEq0/YTjgCKqmBBesxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395603;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TTUFtw/nxnpkCPxNIfivX8Mm378KuN5hPomxuuElLrA=;
	b=vrg0osLa/cobana9GEt+MjSc1zw2uno1KlkDKt0bBtYn56bO8n9naNVqjyUjQBdQLktU
	 24KwlLxcnzi9xAROBvSrNzYwUWFGNE6yHd/fUnBGg0POBbgaO6nXK2af3284XrikKQS0y
	 WM0hSOmrRJiGtkiT0/hmiYTAwHFRd7mgyhfQsvnZJc8ezX7SFDSRyd8mgRVYV4jHXsSXx
	 rekq8pl+C5hkrfHPCIj2vm/FrkqObgROebl+/jia9598xSWFCmwO4RE0FPVI6i1Wv5Fjo
	 zizNMTn+yi8QkyGbA4zHw3hQ2MlhF1o/iu02M5uatErG4Be/TUgPwHgwptyrgMmCxrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=F96wWoY7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6C606A31C;
	Fri, 30 Oct 2026 21:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=F96wWoY7
ARC-Seal: i=1; a=rsa-sha256; t=1793395575; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=N9ZN0xQoJT4kRJpHM0cCQEH5MsHPrdLK7zkOQFVP97l+Avg8KMNwzuD4beVPWq5459BcFYE5Izr/cOMbZcMmXjfiH/Fos22Z7rpVo1bQ2xd9L/jyND09sNVsXERmYl5wmq4j/neaeAir2VukSHOJOiV54wwYQ03IHyOwUnp0Ke8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793395575; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TTUFtw/nxnpkCPxNIfivX8Mm378KuN5hPomxuuElLrA=; 
	b=Rc0zeFhdzPCFnyIiRmQ8S6Up4ZIJGzhKeaxnX8cStr3HusYMOyQR9Nov+TI1fqZWvO68ib5k5aVRUPaD5ft32yq//5rKDrvuBGVuAtCisQND8lGtUl3Bg+v4Tshl8OXNkJ5xEn/Xpr6XmEL3+6ro6fyKY3VVwOlxh0cLlDQB1kc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=F96wWoY7WmkhF0VgiHoa5TMK25awEIFO8KvWBL32+E0EMIO8AAFe7IgN4o6fL7R9DsJsq+VFVHMEFGYX14HaEtOdSwIaZFeHQa+dPttk6q2l/GUlGXdmFtKlzLSEH9/Bg/EjKO0YKkp/QK3GEI6Xrps6e2sMa+FXpeJDUcpDweE=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=TTUFtw/nxnpkCPxNIfivX8Mm378KuN5hPomxuuElLrA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793395574526558.2694898430047;
	Fri, 30 Oct 2026 22:26:14 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Enrique Hernández Bello <ehbello@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com, robh@kernel.org, heiko@sntech.de, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 0/2] PCI: rockchip-host: Retry training and hot-reset a JMB585 on RK3399
Date: Fri, 30 Oct 2026 23:30:00 +0200
Message-ID: <20261030-rockchip-pcie-s2idle-a53-1@iav.lv>
In-Reply-To: <20261028173117.3457220-1-ehbello@gmail.com>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv> <4316c1da-f7ff-4fa5-a330-512800474e45@rock-chips.com> <20261026-rockchip-pcie-shawn-reply-1@iav.lv> <ff204558-dc22-4d38-b0dc-2c727f983f9f@rock-chips.com> <20261028173117.3457220-1-ehbello@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 17:31:17 +0000, Enrique Hernández Bello wrote:
> pin enumeration to an A53 and see whether your aborts all become synchronous.

Helios64, v7.3 with Shawn's hook registered before pci_host_probe(), no
other PCIe patches, a 1 s startup delay on the PCIe power regulator (DT
overlay), s2idle for 30 s:
- all CPUs: 2 aborts in 40 cycles, on CPU0 and CPU1;
- maxcpus=4 (A53 only): 2 aborts in 40 cycles, on CPU1 and CPU0.
All four are synchronous (ESR 0x96000210) in rockchip_pcie_rd_conf(),
from pci_power_up() in pci_pm_resume_noirq(). The hook caught no SError
in 80 cycles, and no abort landed on an A72.
