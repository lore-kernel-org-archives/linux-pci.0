Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602252;
	b=qd76t57UeVBLlHU16liDWpE9u2qUYtcXl/YVrqHkspXr8tWwCHQp7b/F8KsGTddYcKJJ
	 ydBinyKY2wlQj1xVfyWaqugjrytlK5EZycKXw2/yTKmhO6PImTyJ9lMH1ve1lG2lFKhDW
	 LUvlIpExQsaJVobjm+agyqnRKu8IFj5k0B2Octrm1nT0p3+tis3/5KXSNjzZZIlcheQ35
	 el++40+JFwwlZi/43nZhhyxa7GkoCkqptf8nncXHkWKzt2etlGsLHIvc4nsmjqQNpAhG9
	 BGP97ASiVJ2aWfY9OEiaa0F5QKXlf7fhjV1RWtIm9GoE7zGLrUtnbpl++ccbyMJogPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qfsFhryTTz4RhXxObQ1YZegBdEDgfWhPId1rtPYAN/0=;
	b=cpUEUl/LneBR6XCAgsDlUZXix5zY0DVdbnZi3qjD0LEGKCvqDZSAl99mrDEWoNvrchGe
	 a7qV8VW5EJvRvFHwik1VVe0GT/YUBjBJKzKkt2pLH9JAkpVliwFZT5pvqSvg6Srpw+Pes
	 6oj6yIuz1NDq7rvVtBOKlYtq8aLTRj5C1rbuZ5XAVxCFt8IBj4j0K/XlZnIe32Hv6859U
	 32hG2XVxI9IGEuDS4bufCaHl+8Cv03HvUFa4Ppfbn5pa0G38BJLl7OR15qjjxvPNepZUq
	 7M4LSWLdSocIz/6oUIYRolyLDHLcr4xvRENNiaY6WOOECcrLrMrn5NOCCIkfes8lhZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VINDnsOR;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32909606A32C
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 17:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32909606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VINDnsOR
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6798eb0d13fso1152122d50.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602251; x=1793207051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qfsFhryTTz4RhXxObQ1YZegBdEDgfWhPId1rtPYAN/0=;
        b=VINDnsORSUIvFQadjq4cHPlHqnlHeF8K26mLp+HZfwbjThWvtefsS3wsktL0Av3X2R
         6Grz5GHz2hrYp5WExp+PBvIxE6uNI+WwZCKy7AgidYmmR3oUNu/6dVaEHbf9rfPRh1W8
         iDw9x7nHt57ek0II/Xo4S6xts0wUDf36N/IQAYpKTaBVdOiio01ikpdERxw/zZeRMiJ+
         J7oDEFvwfYsYcGnrpehTZgd+qptKONooqiBRe4PlI4kr38aimjghFyzjfh+tq13Nay3P
         3OBTjY5gRLYo+S+MRees024+y3eKnU1/n58duXy+MxWjN1EZ70j2cwnElWf3AMROU8sv
         Mzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602251; x=1793207051;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfsFhryTTz4RhXxObQ1YZegBdEDgfWhPId1rtPYAN/0=;
        b=OxdJwK72ub3Z3nU7cdvSGL65IWvQaUI9oe6figtvpgJVKmYt7iQHsr4P2oDYtf3jcy
         hcY3ivmFvOkPf9klNXIFPbVlAVqNiVM7PKyIpNgyTmSvtKPb3qWt2LDhCSMBTXjSW2hI
         PoqazWR9ArPgJA2dOwkF6a/ZEYmrgHH36fuNn093bd9Ud5wEloU7ixChN13y3gCuy/yd
         xKtXjJc9PkbNL94fmi/CV8ZoLfWk7jIbJ5DEr/px1UITUsFGr/nesFpulA/dDUWgb+A/
         nGbfEwsvYlAhEvncp3aKGLEdnZm+GamDA++7cYiFRKrtfsUovZNAGp+8+IN9+v+GwbrN
         nXBg==
X-Forwarded-Encrypted: i=1; AKwUvBzr2D8NXB/XmUHU5XSM/J/Cd74Bfxm3cSfXs1D8amP0Cte9pfHEePTIOFSxZZfg8wH/37YyjRkh/dQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7fBndeC8+O4DQpf4bkm4PopNPXlzUltuAeJJpyx26P3Nl9xMo
	wtd1Y3W9H+Cw96UTqF4S3zARbI/xaTgtU+oqepVWEcJF/tBd9uWK4W37
X-Gm-Gg: AYBFou3miCN6ncetgFFQYB28r+a6H5VKTurxYbvlDWgM+EzOAZrS2PVkCL/vCnNZLwY
	2v47NV08LOA9nrWJ05xgUdvpRfzWHXSNisE67v4venu3G6ZRZaFKf+Gwmq+jDA8zsS8cl718Hjl
	FOyK7vALQ/TVyB5zTdWyPjEH375CKIOBD2amL+Rjzt21UbMMLWybRAJ95uT45ufnspywOS3jZ+x
	Nb/0ramCzgsjHh9x5cfgeGTd2B6uaPTw1KjZGHryPoD1wKjW5eiXM7aTUiiaeN6hPnnlSVRW5of
	iTkBO24/hV0pnYrmiXVDeIl+Mc6AoRFDter4SdmGs5Kpw8cOryeGzqWfNhWkkKmN0LgDoXTI6F8
	QH89YyrkR+P29gsh5d0xNJwEE7ddEYhFTYz+E1h8YudXZ0lb6hZetKD8CvSB5aOmr5xZ5EYcgWY
	Ge73RJPehpX2GroODXPatIVwwOl4RE8qcBmnbGUkKto8dKYxJ4iwKPZ0ssEANlVOzy1SQilQfds
	/G/iyDgCXClhHYvmSAQmVPcRaePueinZn0IQyCkwN89fHfwJPnPVni8xfWFxQOhUQm1pKNAcHAb
	FUXP3JreM45TWxZbjF1lpHJsDTmCf7WoEM8Mmz4ReuiMG/nL154k0y1eZu3xJEvc9eUwfjkNKHV
	doC+RFEpEXY/x5subwfoC4QyFrHOuH5o/+N5ULgHerLH7vvEqEri2kQEqF3e1nBk=
X-Received: by 2002:a05:690e:1512:b0:679:cbd7:b72b with SMTP id 956f58d0204a3-67a0e56be30mr733933d50.131.1792602250958;
        Wed, 21 Oct 2026 10:04:10 -0700 (PDT)
Received: from ehlo.thunderbird.net (212.153.88.200.l.sta.codetel.net.do. [200.88.153.212])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e491a8dsm1417854d50.8.2026.10.21.10.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:04:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:04:04 -0400
From: Jason Perlow <jperlow@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Aditya Garg <aditya.garg@linux.dev>,
 dwmw2@infradead.org
CC: iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
 johannes@sipsolutions.net
Subject: =?US-ASCII?Q?Re=3A_intel-iommu=3A_DMAR_PTE_Read_fault?=
 =?US-ASCII?Q?_crash-loops_a_PCIe_wifi_device=2C_v7=2E?=
 =?US-ASCII?Q?3-rc7_-=3E_v7=2E3_final_regression=2C_repr?=
 =?US-ASCII?Q?oduces_on_one_unit_out_of_five_tested?=
User-Agent: Thunderbird for Android
In-Reply-To: <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <CABZrw2GfC8SEPiGOUD42um57nKZAghjHz8N1DhMsw8sOC7OAxA@mail.gmail.com> <2c840dcf-4292-4579-a62d-f9766b7cb780@linux.intel.com> <74570358-8085-4767-BF76-D865CA95853E@gmail.com> <40118d49-2e79-45c7-8e50-58e05a44d24d@broadcom.com> <EDE0E273-27FD-4069-9129-FCBB48D12ABB@gmail.com> <1a15f52cf68.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Message-ID: <20F90036-F53C-4490-B27A-DFD055DB22E8@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable




>
>I would prefer the above in proper patch, but it's up to Johannes=2E
>
>Regards,
>Arend
>
>
>
Patch below=2E

-- >8 --
Subject: [PATCH] wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Commit f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf
packet IDs") maps the RX packet ID buffers DMA_FROM_DEVICE=2E The
BCM4364 firmware also reads posted RX buffers, so with VT-d
translation enabled every such read faults ("PTE Read access is not
set") and the firmware crashes and resets in a loop=2E

Map the RX pool DMA_BIDIRECTIONAL again, as before that commit=2E TX
keeps DMA_TO_DEVICE=2E

Fixes: f0ba5fd51ff2 ("wifi: brcmfmac: Set DMA direction for msgbuf packet =
IDs")
Cc: stable@vger=2Ekernel=2Eorg
Tested-by: Jason Perlow <jperlow@gmail=2Ecom>
Signed-off-by: Jason Perlow <jperlow@gmail=2Ecom>
---
drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec b=
/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec
index 069ba70=2E=2Eff47d48 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf=2Ec
@@ -1639,7 +1639,7 @@ int brcmf_proto_msgbuf_attach(struct brcmf_pub *drvr=
)
if (!msgbuf->tx_pktids)
goto fail;
msgbuf->rx_pktids =3D brcmf_msgbuf_init_pktids(NR_RX_PKTIDS,
- DMA_FROM_DEVICE);
+ DMA_BIDIRECTIONAL);
if (!msgbuf->rx_pktids)
goto fail;

