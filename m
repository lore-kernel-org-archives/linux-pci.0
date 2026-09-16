Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0443D813C
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581957; cv=none; b=r1JyE596LKIOj8O/GPoxhPzjyYj6jraM+Isjftrp+SIIJRENhz493XkKk1E75Cv/dzoFHT2uJtZ0jbY8Em3ltsl3b3i93ljwYmgXIrSWk7w/uQNASEwvLjmTOVzcr+4V4MbcGWFaRvTRBqjKdws/VT0x6N2suKSlX2cuDVlpcd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581957; c=relaxed/simple;
	bh=O2v0e5MWfgHWEfv1oF641q0EMf7wlEn7qp2GOsNi108=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLoaMjX+A5Cb123bzj73QpCVEW9Q/1yfmJFJx7RjXgm75+j/UuYyFFx1ChEGuGhkSImSjIKHatNT8f7mx3cmiHtRBWzaPtwE5q1l0+X5jfUTbUuhSfKfrv5vOsheBQPUG9eU5INcitFdq3BidlxNm3B/ukptroRFe7CeeEiM+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RWt7DWXs; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RWt7DWXs"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5c5f23666d0so2272231e0c.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 11:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581942; x=1790186742;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKiJ5aTikUePNqzaSPGRnlcTXk8ED5fLH4IrYfP0KXo=;
        b=vNmAHKTbxbS+D9Nnzrcbt46DWiO2niUkSxqxsH/ZPusIxoE/oxQA+P+xeauX/VCUVt
         iSXMxCTxIxZmb40nc5tLDVb8XktaWTRArjYY1sO5qtG8B3Vz7CamgO2UtHy1iYl9r7r4
         t3+u9e6JZrYj4zCqr7/pOZsCewcZiGARLwKnn6wlh8++EhSYHjHdG45IKpdZTdHTt0x9
         SvBgTrNK6raFnD9sr5dbo1y8byg0H09sYacBRa2zAqtzyk1aKhrAjVWf1XVjXWs+n9Ta
         bd8ZVRObl0vY6Fddn+N+aBClWC6wEujJ2YO4ASCee09WriN5TB/1Y2PZQ7JqWV4b+nUe
         HvFA==
X-Gm-Message-State: AFuF++kzdspB5w5FOe4AMSoTyH0Dky7cs463ALKbsCdLq5DpS1QBwqdN
	Ni9kIdxwWyF9+BVPZG12IM3SuCbjinMFYRKAlAh1e49soBv6gDYEE3QzOfU2jOXvwqNjsaIdvap
	QDDzpXiNSlgGm7I/KDMB0XAaWBm/CX5bG05reKqYuw8rdalLdGn/aKYXkPbfl1YQ+mhLlt70Ebr
	Yvl+HylGN8PEbA1UD1n9rarI0GYn5/bbC5MPQScWHpqlI9NQ+PluEFqmcf/DcOLpgPpe7XSE/ma
	g3LAAr68Fye2Ci1
X-Gm-Gg: AYBFou1iBIzqGMUpNy9t5eQPO2BfGDWARfBTRxTHqbOdxYGVvqUoPg7Oi8ef1CVxK8T
	m00UIPvesxfJieCfvkzTFZEXFafKebG9aaUl3agGWuaDkXyoKhg84UF6ipDN2ndopnm4wL5zDKV
	RyhEGevGt2K7a/UmUP9cGW6jb3LzYe1lyrYwWe1OsLrthjT4W8RdbWLJc4cM4q2Tb+H/yHnA3Q/
	plkzIQUg8RVORB9zomOU8V+qorS8mz4QoPcULs39QXEGFZMQGthBxErCR0E66PjNSKMTERXQYKs
	myteZjPkN7y6WXJAovUIDKMZfbCvZCq6AJQc/6+naSh+hSIMdqhN7mtwrciYkBKYMFa/GB1x6uw
	HRWVErbxc3bOnWakzYjsbbK0ks3Bb9rhCrJYEOjIxEzuQ5MWHCETcEyl/l6wIAOS2H+yOHLuBGs
	U8mxc1j2NtcO5f7b3kbDrSpXEXgWWItgFBwE1p
X-Received: by 2002:a05:6122:288c:b0:5c9:a60c:2737 with SMTP id 71dfb90a1353d-5c9a639702bmr62803e0c.15.1789581942502;
        Wed, 16 Sep 2026 11:05:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-983233e98f1sm130167241.1.2026.09.16.11.05.42
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 11:05:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a9cd44bfbdso19321a12.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789581941; x=1790186741; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wKiJ5aTikUePNqzaSPGRnlcTXk8ED5fLH4IrYfP0KXo=;
        b=RWt7DWXsCH0XO33mV3++27jczpJQILnXlrfrGTAIEaSoIn8RCxlNalHgns6mXnBnU9
         +Vol52uIEBbSrbvOprJ4s9xkIcnvabO8pVCVQjvFHdy+j+bb0fjBi439XNUdMoMmTMka
         SIgmS7EQ4y+BzUWmslB+nD3hbFs1L0dpUGXXo=
X-Received: by 2002:a17:907:fd89:b0:c29:3c6a:8357 with SMTP id a640c23a62f3a-c29e5308b67mr258768966b.28.1789581940816;
        Wed, 16 Sep 2026 11:05:40 -0700 (PDT)
X-Received: by 2002:a17:907:fd89:b0:c29:3c6a:8357 with SMTP id
 a640c23a62f3a-c29e5308b67mr258766066b.28.1789581940333; Wed, 16 Sep 2026
 11:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-14-james.quinlan@broadcom.com> <20260911235416.1E1A01F00893@smtp.kernel.org>
In-Reply-To: <20260911235416.1E1A01F00893@smtp.kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 16 Sep 2026 14:05:27 -0400
X-Gm-Features: AcwNN1UH9m0u8SjrYLAPHnYCJNwRE5QYmI7XyVmlNr6SBSnjrVChuFFj_5AQvbw
Message-ID: <CA+-6iNyRv+=5ryA_FYKTpzY4DXpjjUNd7hR+pRKwadUzZTp0Xg@mail.gmail.com>
Subject: Re: [PATCH 13/13] PCI: brcmstb: Split up complicated function into
 two variants
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e724a8065b9d83a7"

--000000000000e724a8065b9d83a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 7:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] An off-by-one error in the inbound window limit check allows one=
 more window than supported by hardware to be processed, leading to out-of-=
bounds register writes.
> - [High] The MSI target address calculation incorrectly hardcodes the arr=
ay index `inbound_wins[2]`, evaluating either a disabled zero-sized window =
or uninitialized stack memory instead of the main inbound window.
> --
>
> commit 2fa82ffee79e487108d802c77822d346d0a063c9
> Author: Jim Quinlan <james.quinlan@broadcom.com>
>
> PCI: brcmstb: Split up complicated function into two variants
>
> This patch refactors brcm_pcie_get_inbound_wins into two variants: one fo=
r
> newer chips and one for older chips. It updates the configuration data
> structures to assign the appropriate function pointer to get_ib_wins.
>
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 53984cfa2c96f..45e8a9e030d4a 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> [ ... ]
> > @@ -954,8 +957,58 @@ static void add_inbound_win(struct inbound_win *b,=
 u8 *count, u64 size,
> >       (*count)++;
> >  }
> >
> > +/*
> > + * This is used by newer SoCs. It configures the inbound mapping windo=
ws
> > + * in accordance to the values of the dma-ranges properties.
> > + */
> >  static int brcm_pcie_get_ib_wins(struct brcm_pcie *pcie,
> >                                struct inbound_win *ib_win)
> > +{
> > +     struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie=
);
> > +     struct resource_entry *entry;
> > +     u64 size;
> > +     u8 n =3D 0;
> > +
> > +     resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > +             u64 pcie_start =3D entry->res->start - entry->offset;
> > +             u64 cpu_start =3D entry->res->start;
> > +
> > +             size =3D resource_size(entry->res);
> > +             add_inbound_win(ib_win++, &n, size, cpu_start, pcie_start=
);
> > +             if (n > pcie->cfg->num_inbound_wins)
> > +                     break;
>
> [Severity: High]
> This is a pre-existing issue, but does this off-by-one check allow n to
> exceed the maximum hardware window count?

Ack, will fix in an additional commit.
>
> Because add_inbound_win() post-increments n, if a device tree provides mo=
re
> dma-ranges than the maximum supported hardware windows, n can exceed
> num_inbound_wins before the break occurs. The function will then return
> this oversized window count.
>
> If this happens, when brcm_pcie_set_ib_win_registers() subsequently itera=
tes
> over the returned count, could it fetch an out-of-bounds register offset
> and overwrite unrelated hardware configuration space?
>
> [ ... ]
> > @@ -1195,7 +1217,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_=
MASK);
> >       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> >
> > -     num_inbound_wins =3D brcm_pcie_get_ib_wins(pcie, inbound_wins);
> > +     num_inbound_wins =3D pcie->cfg->get_ib_wins(pcie, inbound_wins);
> >       if (num_inbound_wins < 0)
> >               return num_inbound_wins;
>
> [Severity: High]
> This is a pre-existing issue, but does the setup logic later in this
> function rely on inbound_wins[2] being initialized and valid?

Ack, will fix in an additional commit.

Jim Quinlan
Broadcom CM/STB
>
> In brcm_pcie_setup(), the inbound_wins array is allocated on the stack.
> Later in the function, it calculates the MSI target address like this:
>
>     if (inbound_wins[2].pci_offset >=3D SZ_4G ||
>         (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
>             pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_LT_4GB;
>     else
>             pcie->msi_target_addr =3D BRCM_MSI_TARGET_ADDR_GT_4GB;
>
> For newer SoCs using brcm_pcie_get_ib_wins(), if the device tree provides
> fewer than 3 dma-ranges entries, could this logic read uninitialized stac=
k
> memory?
>
> For older SoCs using brcm_pcie_get_ib_wins_internal_map(), inbound_wins[2=
]
> is deliberately populated as a zero-sized, disabled window. Does evaluati=
ng
> this zeroed window result in misconfiguring the MSI target address,
> potentially causing PCIe device interrupts to fail?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.16=
50895-1-james.quinlan@broadcom.com?part=3D13

--000000000000e724a8065b9d83a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P6nIShznyqOL2EoCa0IXujxvXUo0pANFYsDhrCVF5JOVPeEL3Y2m+4flRtOI+YlRQoepb+TEVdkY
/g1rlWG7GIYrtHxrFFRvn2/Iqqpv/x5kzJgoTYFOyTTGlXIqGkKTqCWFrN09kJWzhhmxhxtJprJs
KveDLF8yhHSbqmXfKTkT+CIrynXXDro+80qXEXC8CM9W9d+2lDDM+hWTlC6Pt/ikMYf/ZB4K2Nr8
VFruDYGZfAHhh9/lqK3SpS2Z/8cB88K62U+Eb1yNAgMBAAGjggHeMIIB2jAOBgNVHQ8BAf8EBAMC
BaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYB
BQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNV
HSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wQQYDVR0fBDowODA2oDSg
MoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCUGA1Ud
EQQeMByBGmphbWVzLnF1aW5sYW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQiuRLoBkhIaas+1j3yf23P
ffVFcjANBgkqhkiG9w0BAQsFAAOCAgEAp1y0fznw9Uo7UzExANVpYjj+OG1c3C7MhWOvAd7LvfPX
BSFisMaabop5Pyfc/sWzb/jCNfVkkDW5Ij2mzpUsUca2qpILoFhOUT9b0d+nc48MCZ4/Wj6vX5QJ
i9VdYeuv3DYASZsQdH8iYnV5X5YCYo1AO/pyW+M4gG022Nsji9+3A9zkx8JRPDIXkPaDLrzcGD9L
rEVIYnnSK9b/4VHzITVgEmSsUTAIzOD6M6TzgrSoJZFmKNMXlAqo+m1nlNyJkM4OyOvaDx5y+2hA
mp4tzD9gJNU9TzQpQRZFz53+c8BkCpzvcHqT8lMluRlCrIYWqaSOUDHX9HPYvzbtO4iYV+irMdGN
2PBz6Wtfaoi1xTfFSKK9ON1mvxACK+E4B5gycSoZcOBADTbGXLDMqiygl7Wz0oooAPqZpUnaD1nc
x/pX7N8Ff6YK+iN3vVah34vLkE1CMFyDQMtyTCzQPW+7XCTxCL9ML3LBAF+eNAtKpPOsrGIdRHy5
6oQr+2ZquSMvWj447q4v3sk1LHs7ata+sP8/kmcPKn3WPXQ/4xMevqFVyv2VIFrBK9ZnOZ//fz8R
7SjJ7t2kOITvbWcMkizMc33S9hfmYiXaVTjIi89NiO3EXCJouYShpptgGNG6mpYHcddnfdKiILOS
06KlKNuHO4IpRmaGrzcDjsUQQSn8amMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFI4
NesFxTZxaK54YD4cDqFiVWKPnGHr6Ta3lmduJYSvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxNjE4MDU0MVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIHMHV40ky2ndDaG/0JnibnO6B1qAg3YYdaCNqUX
2yg6IPUpDPzO81N64TEUka2vMvDCYzgyGsgxWQN6fqBd7i53qRTBiKlZiZJ2G0PuTJnslcnBuP9g
c8KhTHAD8wvcZislZ6bAjoFrYBrTiFVlJ9QSzGYltmIi9KCeu1QY0Rrg9rKjzlbfckN5Bwbo+40s
naiiI9y0RSBsPAryC+mfONsM/z68nOS5K/13x/4ZpNs+qFVJFO2tia8oxQZUdj/ivlkTVKvLslaW
R+AHlbfEyZhL6uHa4uEyyRcnbF3OpRFt3JpHkF5z6dp6pNYPyts708Ctafb0UGOy+ZUIgxS4fNA=
--000000000000e724a8065b9d83a7--
