Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793967094;
	b=sfvlE1tH8Ofg2QNTn1BAnwy+E2b+aC3XNn2T5HKBK2Fx58cbGNuR5lOylpryMj4cPSzy
	 s12NWPtK8tZQFkLsgv3/Ciz4i7y6ZK2e4h2bjUJDx0epTUcZpcNj6dUvBazmBLNl2gaDm
	 mtExDCbQ9EjVzmY+QpLLT7EqP64KySI378h7P1kNbz9anFKuBdIycK69pwdrb7b8Dx1EJ
	 xOFLyVG9HLEGKh6asIK1c52N/yvdlNXP/udtftxgQbPS8pl0QFgMQfMX/avB9Ov9RX43q
	 vKp/K0+WHr5vJ7CVCSFS/QRTBwk9y1yCbKxl1HwsLrOySwawFqzeICoGq+B7isDKjQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HaMBJ9VdOEiBAxflufFgbsIfyCEF7W4YXAUVe1OEFHs=;
	b=c+ToBvIlln6UjeQKVsmoUxG3t/wNuw/AL8fQePMvNaiSXLilY1Z1Tw8dlBGfVbNOTMu0
	 EEcvXjTX9YzP95RfGVwrixITKkyJ5CshaqV35O9Ewt7kM0KkCb99o0mfi9OofaM92lMBX
	 YkRWJCW8pP0sHELfLXnjyhQyJOE6sBuyQEk31NE/TP2prMyJN04gvGUtVv2+Xl/rL8mQY
	 rb1KF1VBSIX3r06AVMHbLukbeM/2g5oXmOwDKD8BdoX7PzfftCesyEPkr6ukSxLLuPCrn
	 X5W2kSpLQJBxZ8ZSekduzRgrSQ5AQkxEKo4yC9f/apfBAvHSPfa1D8Nr/2/wIFcJiCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IZF/Bzzd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7C606D825
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 12:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52F7C606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZF/Bzzd
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so5635401fa.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 04:11:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793967092; cv=none;
        d=google.com; s=arc-20260327;
        b=QKZtqPPCqZEEvaFMoI4YgaQ3hAGTdPGFpxEpqy3bjUkNuglFmj848MUwx3aCDm+Dkq
         8tF86i3aEMM6gPecaaSOW1gQV+5nxe8gMeGwR5h6vhfyULfkF80UVzbMlsemxoN8cuRB
         +N69n/ML+RC9HU6ooDOhlP2MnZjq5ggcMsMM6caxdqtboLBfNV+4iuonA1KNrrIF3lgK
         qrZkk7SCeET76R3V78D7v9u3qVd6ImeRZbfOrBJr2vmhZ9O4lcl71v6G3x5qfVVGXmjN
         /F5av8VmQLi/iCAe2PByQFUehvGTMfDQDvOQSsbi0GmDS4OUNoOqeu/9BKSPpbDwTJA2
         Wliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HaMBJ9VdOEiBAxflufFgbsIfyCEF7W4YXAUVe1OEFHs=;
        fh=9ok5iax3MkZxnCskPrZfux+fX04ckgwXjOtuIeFJg+g=;
        b=gK27x04U0nGdBQPqhp+lkLwQydJbYs6rFPVYU91uYgISub2FU4z2gnIKCH/MlhFh1I
         2qOtF+6a2GlnVTA0LV9y0E88dq7kyV4wc5xy1wxo2eJ+gZoMXSS4Lgc4k0Er5JWKLp84
         z8XkiqcYQlSDFzPMG5LhJv2o96X1SbJo6FecifwsEvpnAT7+bLeDr4vnpvp7GO+d8VxF
         NE+BtVdvR91oJfnB4D8AEH80727ofswShzllQwdouZzisXL8W3FmUF9vaGdw9R3xfBxf
         dYRo3UfqA59Ehlit/ITDVdtGHBhd3x9pOdq0+hRYSiqXOtzyjWw/xXE5BKcKAKV4TBBt
         LihQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793967092; x=1794571892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HaMBJ9VdOEiBAxflufFgbsIfyCEF7W4YXAUVe1OEFHs=;
        b=IZF/BzzdlFWylnYqA91PN1wF2Eg55i9A05RS9i/ErJ4lUQBhNYZjvV7H4H6QA9lOYu
         k8IXKOgM5s0qvmdUJpxrH+FLbeQXhxW/HUtKyMCpfuYe5UF9DKy+RCYLEt26Hww0zRZV
         qiBJxTwxm68aFeckSF4ZN/flpBBXa3AJ9N2RnUsn3v3eWpbDEmZH641WzQce421aQJuZ
         KKcRSBTr2dfQMsVNqgsW2ibfXxlfov24+CPdNiVOogwZgFxJ2LQpak0F/xJE6af8Wc84
         vf7x9f3rMk0FdrMlV29NwYL5IEWmoz2sNq5fo+5uIe5t7+mqnRG1AHe9Km6Nyy5qk8nW
         AAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793967092; x=1794571892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HaMBJ9VdOEiBAxflufFgbsIfyCEF7W4YXAUVe1OEFHs=;
        b=gVWDQWfc+XZXLD9CAPLVD2Uy4fMTZW+iKGsU9ZoWV41qbalWq+XrRM2KQdHywuXdFV
         awAJLAR/hfp/FEZDsqTIbbAqet7wytpbqPgWealgXUYxMjx4yC0AwTF3Ymy6nsg2Bvp3
         rehoMDLGub07iA1EaoBRHs2gazFtsZP0ayhbHT9N+vXSBIX+J7B2TTpJ1rwTzYRSl/uB
         sgu5Af3BcA1dj5kaJTM+LKjZkQSLFOvXEG+aKb3cKiOleyLnwae3CvIYL0Y0dj2AIplK
         Lo3bFpNomoJnfmSZ21ETJ3Lhs3XQlFNKk7EQCLzDA4ZDVpcuVRrZ7mZ2C0pVSz7DqXYU
         dP+A==
X-Forwarded-Encrypted: i=1; AKwUvBzWA7jApX2xK/zaaAG8sPkMTRnhkq2tAYrn0G891cohAPXCC8DHiXK5uQ4mZtt6RxEeqWx0MS4x9xM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1vVZ3ViMYg9wGct+7ifJEDZi/c4k4xtC0kX3XiT9W/Af+oVUJ
	saMlpsYW8fwfUzzDGXlufkYx2RXYyiNF+cneI8yN3mXqVoFdF7iEVYoAfYgKOndDy60w+1FADoh
	QOF6Glh35G6yIvDFwSlXrP+fGiHWNOqk=
X-Gm-Gg: AYBFou2oOilaYPb0eJkkEok6j9/XwpqjsxQQDZADuHNMt/79dMpWR/GI1jnzPGCXpdD
	NLWE6xHS1ofr+fXwh50OT7ha3KLgx9BQYFwpG+l/EKCOJEQsQl9eODY29pn9Lrf9UzrTYg8cCIR
	Mv+WNGeYr8Z7IDsgd/E6FiSqegvb///SgYm0xpeJscVhaXoJuK9NVvilUjEXZFnxS4/xOj7RKGr
	Rh5uOfotIcu8g7A4AWicrQwoySRnua3Ud2doJGYmfI1M8Y8c36qGxZWUCEv7tGgqfUOIl0m4n5N
	ThgAAvK8rYtb31WudwC3OYhzQPWS0QCQlv2dLI99a1LLZ0aYiqnKL+/P1dO0CRMO84lt717MUsF
	Hi8rnd6f+b3o6U20CqVCJ+733/weT/A3F0WSsqVIFj0vaBhsvptY8A9yqitMdgcS6pljRuJNDBp
	fVr64ySmh9z76LarazSmwEwsCcCQ==
X-Received: by 2002:a05:651c:a168:b0:3ab:ac4c:186b with SMTP id
 38308e7fff4ca-3acf3a17b03mr4522841fa.9.1793967092260; Fri, 06 Nov 2026
 04:11:32 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106090342.2601665-1-hongxing.zhu@oss.nxp.com>
In-Reply-To: <20261106090342.2601665-1-hongxing.zhu@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 6 Nov 2026 09:11:19 -0300
X-Gm-Features: AclHuK9TdxwLahGEGzjbAfd8oBsJGMVuCCTSxGyqd0oZVKPE9N9p0AqrQOMBJUs
Message-ID: <CAOMZO5CQtcpb04Vp49Rg_+DHoozRpQthW3_YNAYQHqi=VOmpEg@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: imx6: Enable L1SS support when supports_clkreq is true
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@oss.nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:00=E2=80=AFAM <hongxing.zhu@oss.nxp.com> wrote:
>
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> Add support L1SS support for the i.MX6 PCIe controller when the
> `supports_clkreq` flag is set.

Please explain why this is needed.

Also, does it need a Fixes tag?
