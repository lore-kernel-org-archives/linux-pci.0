Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11178433AD
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668492; cv=none; b=fh+s5ldv8QsU6FgSMwBFlIJX/CSn0qdw2ULMifGjaAdVrwgB6x8gJAZrKwia/MlropZaw6/GTfN2Zd2A9N9YfyD6DHw7NPvegqJF0Y+1aBCqhUlaqPKIJSBg2aGj/lnl4OJvs8EplhvVSy3P5oHCgT54NcBLd75A+08jUKSNIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668492; c=relaxed/simple;
	bh=gGeL1YJ0CYyxHFawhvOzx24WV27nFYh5rjYNL9HiMno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjIqCymRjswFzFWPMRFheW6/R5brVZlsoaZmjaRUhLPAdNBY/zm8y6zOrEIs7j0tumWefaGLTKLNMxxZMVH4/U2a00ECZfNSRhfO35AlvOCIKGc7pUkNvGQjPSqP3xfikYmS+6GM5F70g0VKuhnGWIoUufdyFHjJLH4/doqbhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZdCzwAA7; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZdCzwAA7"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2d91ff7d9acso2791725ad.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 11:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668489; x=1790273289;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jNNkSO3iwNZT8iFOw/GoAcbks1of6H5HS3MceoMKJTc=;
        b=FOF/wrxh5PdCpeyDKB0wr7S7Kz8sirS4u6fSd4P8qNz8KLc/9Qb5Co/E9DaZ0541Vy
         J9QkqPLa3UkWorFMf1Lyr2ZAEDDs+I4woYpc9114+VKhG8MtcHVOVNpuQp9wLX0q35ux
         FWPU++zG0KN5Zb1Eo/YOHPSIgRc0EfJNiS735qgcVAEuCXugnf8DNY8jV4Xd1NZ4cnCO
         pTYVOzGY5//Hc16eR+XTPBL93cj7C26bom770Se6cNPaXfwB0lI9PkBq6eiBXo8DEAmN
         fYMuFZDKTLlZtyOi3o9WTgyFQ1ZTR6r42PGbNlSC6GKRabdC7TW8Kcqcx6PmNvnAnFFO
         riMg==
X-Gm-Message-State: AFuF++lE+ByCVsIgxDcApvyBn/GOXT//pLdhGMYFezIsnV8QrPo/nMgH
	QkGICeL2VduRDOKcul9Tm7BO7VSFQxgXhl9A1Hr+/pFm586sIk0z86CC1rXNx8gRb/DH0yuPhwA
	KvXgVjhbmDMJnX/n8Y5K1c38660/gBXwjtCgS4OhKdADshKVIodnWvCC9iRjnO1bzIduG/1KbsQ
	xNhaPXEICnVOOV8cwhl3Aywbl0a38FDr0vlE/UB+KXl9keLu81P0gJcCN4xKXD6eVCrf9rH/lVK
	wP+WCRD6dM81D6p
X-Gm-Gg: AYBFou12nOE3LEyjOriBZmmoHvY9YlFkmawGR7kH/Wv2cyk4mfqWATIEBYUnBJwZGnK
	7GN+T524QMYk+MJv0Csjm+6LjVXPUgYDKh2zvoXTARhdc5HRLN+iZrneq8RuOxUmrdzb1BSsE27
	yRUNmn+lbkzswVez7pjm0WzeJLpdBuz439Zf0tXUi9LmO9jycMgo4d/sWwblzffoA2UvwidNZRb
	8zrgxSmQ87W1dpPjX51hP6gaYzdjbHr90oBlmeYFOmpIYLMGcNatXhwMmDUdElhVhOwh2nP/Ws5
	fFuLW+/J6tqE+vsZO9WiM8HpL4NRa8BTlaD+JkGvtRk1O4YL/k6XLD+Mht/p7nkzoEPKcPcFV2l
	z/FOXgcoE2Nps7ZM0z8IMu/0fZdVeoE/aSBKdScx4PqD3fyPoIfvlzGpnE99qwmdsGiK+k2xfDd
	quxCYOZ+XBxI8eV29P398dAhPkqxgW1wVTMCGh
X-Received: by 2002:a17:90a:d644:b0:39e:288:80c9 with SMTP id 98e67ed59e1d1-39e1e4d3fd1mr16682255a91.19.1789668489188;
        Thu, 17 Sep 2026 11:08:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e35e23adasm1882330a91.5.2026.09.17.11.08.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 11:08:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29c391bd2fso116567066b.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789668487; x=1790273287; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNNkSO3iwNZT8iFOw/GoAcbks1of6H5HS3MceoMKJTc=;
        b=ZdCzwAA7BgQ8LKjpWg8/cMikgIEaj5PvQ2+nFmE1QfahIB6NjFKkdcumTSNChBQsqB
         VdcZdGhubygXRLlyqMqxIpUs8QNyLV49jEMlr2/iY9CQD2CiJ9rWaER0O7pn8N0Js77q
         RWXa0N8MHYGBt1KRwG36JOmd6wnuj/VJJ1HPc=
X-Received: by 2002:a17:907:1c91:b0:c29:62d8:68b8 with SMTP id a640c23a62f3a-c29e532b637mr572225966b.48.1789668486759;
        Thu, 17 Sep 2026 11:08:06 -0700 (PDT)
X-Received: by 2002:a17:907:1c91:b0:c29:62d8:68b8 with SMTP id
 a640c23a62f3a-c29e532b637mr572223966b.48.1789668486322; Thu, 17 Sep 2026
 11:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-12-james.quinlan@broadcom.com> <6ce4208a-3869-4eea-9ae1-06985c9774e7@broadcom.com>
In-Reply-To: <6ce4208a-3869-4eea-9ae1-06985c9774e7@broadcom.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 17 Sep 2026 14:07:53 -0400
X-Gm-Features: AcwNN1UU-8XC5Z3nHrhgoIVmWAvdQIlVjifTkLgZoE09TXPfLT3Nxu4b8U_xWlE
Message-ID: <CA+-6iNznU3xyESOZYWfYFKghTgOLy0Vd1WvMCd=1EJPfBF7M2Q@mail.gmail.com>
Subject: Re: [PATCH 11/13] PCI: brcmstb: Put max_burst_size setting in cfg_data
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000715a3c065bb1aa74"

--000000000000715a3c065bb1aa74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 1:05=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 9/11/26 16:35, Jim Quinlan wrote:
> > Rather than ascertaining the max_burst_size setting by comparing differ=
ent
> > SoC IDs, specify the setting in the config_data structure for each SoC.
> > Also add a comment on each SoC's encoding of this field.
> >
> > Note: Previously, the max burst setting used for the 4908 Soc was 2.
> > However, it appears that the setting of 2 is illegal for this chip.  Se=
t it
> > to 0 as (a) this is the safest (smallest) choice and (b) the 2 was prob=
ably
> > interpreted by the HW as a 0 anyway.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >   drivers/pci/controller/pcie-brcmstb.c | 29 ++++++++++++--------------=
-
> >   1 file changed, 13 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 047783e33ae4..8bca98e6f5fa 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -317,6 +317,7 @@ struct pcie_cfg_data {
> >       u32 flags;
> >       u32 quirks;
> >       u8 num_inbound_wins;
> > +     u8 burst_setting;
> >       int (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> >       int (*post_setup)(struct brcm_pcie *pcie);
> > @@ -1153,7 +1154,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >       void __iomem *base =3D pcie->base;
> >       struct pci_host_bridge *bridge;
> >       struct resource_entry *entry;
> > -     u32 tmp, burst, num_lanes, num_lanes_cap;
> > +     u32 tmp, num_lanes, num_lanes_cap;
> >       u8 num_out_wins =3D 0;
> >       int num_inbound_wins =3D 0;
> >       int memc, ret;
> > @@ -1188,20 +1189,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pci=
e)
> >       /* Wait for SerDes to be stable */
> >       usleep_range(100, 200);
> >
> > -     /*
> > -      * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
> > -      * is encoded as 0=3D128, 1=3D256, 2=3D512, 3=3DRsvd, for BCM7278=
 it
> > -      * is encoded as 0=3DRsvd, 1=3D128, 2=3D256, 3=3D512.
> > -      */
> > -     if (BFLAG(pcie, IS_BMIPS))
> > -             burst =3D 0x1; /* 256 bytes */
> > -     else if (pcie->cfg->soc_base =3D=3D BCM2711)
> > -             burst =3D 0x0; /* 128 bytes */
> > -     else if (pcie->cfg->soc_base =3D=3D BCM7278)
> > -             burst =3D 0x3; /* 512 bytes */
> > -     else
> > -             burst =3D 0x2; /* 512 bytes */
> > -
> >       /*
> >        * Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN,
> >        * RCB_MPS_MODE, RCB_64B_MODE
> > @@ -1209,7 +1196,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >       tmp =3D readl(base + PCIE_MISC_MISC_CTRL);
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK=
);
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_M=
ASK);
> > -     u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE=
_MASK);
> > +     u32p_replace_bits(&tmp, pcie->cfg->burst_setting,
> > +                       PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_=
MASK);
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_=
MASK);
> >       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> > @@ -1961,6 +1949,7 @@ static const struct pcie_cfg_data generic_cfg =3D=
 {
> >       .perst_set      =3D brcm_pcie_perst_set_generic,
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> >       .num_inbound_wins =3D 3,
> > +     .burst_setting  =3D 0x2, /* 0=3D128B, 1=3D256B, 2=3D512B, 3=3DRsv=
d */
>
> Not sure this one is much of an improvement, especially if we end up
> repeating the comment,
The new code is simpler and does not do any "if" conditions like
"pcie->cfg->soc_base =3D=3D BCM2711".  This is the commit series' major goa=
l.

Additionally, the existing comment lacks sufficient information for someone
to change a specific setting. Of the nine comment lines in the commit, only=
 four
lines are duplicates. Also keep in mind that I plan to add several new SoCs
in future commits which may require yet more interpretations of this field,
requiring more "else if" clauses.

> also there is inconsistent decimal versus hexadecimal.
Ack, will fix along with s/Resv/Rsvd/ for consistency.

Jim Quinlan
Broadcom CM/STB
> --
> Florian

--000000000000715a3c065bb1aa74
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWwYJKoZIhvcNAQcCoIIVTDCCFUgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLIMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGkTCCBHmg
AwIBAgIMBzO6R+cO6O0G+8l1MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYxOTA4NDUzMVoXDTI3MDYyMDA4NDUzMVowgdgxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEQMA4GA1UEBBMHUXVpbmxhbjEMMAoGA1UEKhMDSmltMRYwFAYDVQQKEw1CUk9BRENPTSBJ
TkMuMSMwIQYDVQQDDBpqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbTEpMCcGCSqGSIb3DQEJARYa
amFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQC8AmhbPVfLI9wqrMBL/9KxGsC+34dY1TTZOQyoill5MnWSx1ZB+JjNsva/GPK27JShDX9J/9vZ
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
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINZK
hMGyDyPOuUZs1N2ag+Aw3q0dJX4UilBb8byBVATaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxNzE4MDgwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFFK7Odpq9EablSgtblzzAl/P/mJU+mAMBpSNFpu
omcP2HQAjwUId1+h0CuumRHlktWGyZbK+IcG7zquyk4+ztq6rjTKCx2xUVoXwsfrWZMRqJfBB0n2
c6RiejE/T2loHtTi4OgpoKnEQ8+odfrla7lw+nappaw/esu7u7DLbnbsqOa2V6bowkmhHE9Y5Hng
UksZtfRT3Br/Y7Shi/OSJrd4tPLw4MU0RSOPKVyIrTACP6JfkNKX4zJC96v0i1AoNI2n5K45kmCv
Z8OoAM2wLRL+mHMVEnzet12HN4TsyVf48YLnwpH08gyICOx9PGLQ7Am2M9Cqv9w7SaQv/TOTpHc=
--000000000000715a3c065bb1aa74--
