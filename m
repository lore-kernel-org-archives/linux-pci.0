Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558052;
	b=Ji+cwVENr5r569JR32WKI8DOcAvZmSo19lLZWO4N7nQH+oJ+boeqfVH323jnxxmskSLN
	 E3SO36G+aVfawLXYxiEKrHU/eKrkj127DbTTGzXd8Hez/EtFgPL4Ol77OYGlQMUELzdHU
	 gTMT6XcDc07rcXUIABH4ty3wp5dF2voQDdqt0ZsziQh2yz8RZh2J8zIti7a4QMOl0JLLW
	 6GS+BJU0DWGtYsTr4ilxvoNpT9FmyOOb1Migr8wh0zyzeWnDvnq4dpLZWRBP3ssFImc0a
	 fVrwFS0W0xsyXbgsnU/Rtj/YXqApQi6smsFmRpVfMoQBwzLThy3Xa2vw4cg1barnhmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=decjdPA/Qbd5BdrOvVz8rHTOK2aIA3Pv62cYSQFfWc0=;
	b=A3qyBZm2B7ARgKazJSRxc8YccBAPg3Nd1F+dnMcdSVi7wCYjLDUUiedxmM57EwHVRPMW
	 asH6QRixUpuvbqvU7aiXkFQe/ZeRX79j8a8B53zToSw7PN/bu/zMUhvU5BtoflNn1BOUn
	 9ahZMVhq+BAnuiF7+UxlRNpRlDYSgo4+x3y3zzOD8yc7Z8otNosfDjeZKBoP5+dcccyl4
	 N+T5KDE6/iiUDuL52LIgogZ9zU0cLDVWaqFY3I7a/A9A443fDiS1gUKYTdk5fQHRxOpZS
	 gCTIAVdfaJiGxYhNz1/rF3MrHwSA63soeIRI4cUd/JNq13S6GkWGHotZdR9NTA5RwcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLLMLO18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BD606A319;
	Wed, 21 Oct 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLLMLO18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7921F000C9;
	Wed, 21 Oct 2026 04:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792558052;
	bh=decjdPA/Qbd5BdrOvVz8rHTOK2aIA3Pv62cYSQFfWc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLLMLO1806wCC8H95p78RUTFwc7pwlGaD82bpMSzwx9s22zuLDZgFcKwsxvhXJnHl
	 /HNv6RZDoD9dJNmJdIAwAV//SN2sSSO5aaqHkv/hH409pb8KeLyLMjH3c7Y7I23DaW
	 JZCGpaZy33zBoCSEFvaEgDNio8lZLDYVMEcUBdC0O22HqB08OUbcK/u/gAdxagocuY
	 pEXWFTiOVAU/StQ7MFwdo7RQoBe7v+x+OquSR/rMpPvfy9f5ULuZHbZmRlUAJt0+ao
	 bGeWeriKRnoo9lXgGkLHlp90Qz3tTfizbSjvT7Gsp4qy3OdH3VdruWWEtPMJGxKk+N
	 3eI4ab/OujaGw==
Message-ID: <sashiko-outbox-179795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] PCI: endpoint: pci-epf-vntb: Export endpoint
 DMA channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261021042229.2280937-6-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:47:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: endpoint: pci-epf-vntb: return error in epf_ntb_dma_set_bar=
() when !dma
--

commit 31737c4f08c2b9d1daab53d00daf98b9d845d441
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels

This commit adds support for exporting endpoint-local DMA read channels to
the RC through a configurable dma_bar configfs attribute and a control-regi=
on
extension. When configured, it reserves the read direction channels, maps
unassigned resources through the selected BAR, and adds the
EPF_NTB_COMMAND_SETUP_DMA_BAR command to install the BAR submappings.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 3adbaa9d85db2..ac83af54122f7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct pci_epf_bar_submap *old_submap;
> +	struct epf_ntb_dma *dma =3D ntb->dma;
> +	unsigned int old_num_submap;
> +	struct pci_epf_bar *bar;
> +	int restore, ret;
> +
> +	if (!dma)
> +		return 0;

[Severity: Medium]
Should epf_ntb_dma_set_bar() return a negative error code (such as -EINVAL
or -EOPNOTSUPP) instead of 0 when dma is NULL?

When dma_bar is left unassigned (NO_BAR), epf_ntb_dma_collect() leaves
ntb->dma as NULL. The only caller of epf_ntb_dma_set_bar() is
epf_ntb_cmd_handler() when servicing EPF_NTB_COMMAND_SETUP_DMA_BAR:

	case EPF_NTB_COMMAND_SETUP_DMA_BAR:
		ret =3D epf_ntb_dma_set_bar(ntb);
		ctrl->command_status =3D ret ? EPF_NTB_COMMAND_STATUS_ERROR :
					     EPF_NTB_COMMAND_STATUS_OK;
		break;

Returning 0 here causes epf_ntb_cmd_handler() to report
EPF_NTB_COMMAND_STATUS_OK to the host peer even though DMA export is
disabled and no DMA BAR was configured.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D5
