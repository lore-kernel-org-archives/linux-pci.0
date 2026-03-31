Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3C3A1A2D
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984087; cv=pass; b=QsE9DAIdGXgkN2hfHoEwXsBPTAGkc4DPgPtvA0MM0MaCi+6owhwuHZF1/fb5Bh81dNKyLEGiu8NTEUxL96o6u+9+dSSZ8fW5NAKJAEmBtOykKXlpD+OBF71zFxm3nBPCAQiqDthjwc1VaUcy3OkRI7BeaZ7y/evrJy38yrX61GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984087; c=relaxed/simple;
	bh=cJxCjybLxyxpFlDM1A8f3u3BoWGjrWbUTZYFDV1UWVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFQrDSYQdQZz8PgeDTsD43w++Iluiln0zWY6L0id7mPeCENMgEWTnMQRQFUi2Dy/Clndk8QFIgjCEu8gH5iUCa5E5AxPAB/4en135t+exMPfIRD8/tOWv0UsN8piU5B8LjFJg3JD5gabmXJK6dxFIOs6QmFio9XKy5q9LcZGekA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDeOj800; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDeOj800"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso5010113e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 12:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774984085; cv=none;
        d=google.com; s=arc-20240605;
        b=SCm/ggzfEIUDh9qhxM82+KNyr17DIoZFk6iHHrbdBvr5ia5RW6qwiSjQQPezL/bObe
         IiaL++xvBpEI+dnCMgjIF46BieX9tKAI2DdEuGsUAZ1pDyORFfaVIJi4BnuSds/a6z8x
         iXb13NMLrB0Hk22UwL7S2elpqUHA15cr46y3VIa9S6GjuIuueAe8FzNExEcyg6pUszIt
         rM+fQj3b7z/6HAcjQS5sZpo6ibUy5BB8kU7V5Bhj7+cJwyZf5sSF/JjRD257IRJZlhlp
         f6haDsOdUGJzni/W4XocdOduEtwNpOr5CuT9JJ2HZDDA9aspZUh6Vobiz7OzF7cBK08j
         cklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ODJKUE42J6Rz5kvZbkeA/0a+pxH8BWcdgMi0Zx2VGmY=;
        fh=zkesMGVogWbiAtYqv10LshuRJWX7IcYrF2sslPLaPm0=;
        b=KHgr7nscqcRZAYK258skgw+L0kiEfr+H8dww+mPB7iVgUE89MCPqF4yZxThdnqSxpH
         E1kslgp+SaZwramSwtfSP/X0TznvwhnIz29Kbg7NZN4grOUO6rg4B+6SsbiY875BsqOR
         brqzd/yEgdqFEtbO0sLK75qdNeLo6RGbcv+0WhpvGBjWcd2YjFJ3ipIz2IBuN5VQNfZ/
         r9lwy6ZVxZ3k8Iy0YQpNIejv2/KHSVo94F97XnfDM+zrXHasQdqAcPBOS4a0W+ot8W7t
         5DJOKpXt+QQLH7b2uKz3rkLAmnb00xmZtALwDQmc8lTS1nJJSaqL/i+uUMgjFXQpaABH
         Xehg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774984085; x=1775588885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODJKUE42J6Rz5kvZbkeA/0a+pxH8BWcdgMi0Zx2VGmY=;
        b=GDeOj8007giXjVyrlWvNJ4Kc2BMKVPW7b3iqiX8SZFx8loVddW4f/Di51syBJogLxi
         B1tbhnqVcZRbv/zlB3GkkgKry8FGlVUTKfm//SdNeiOYnves6dR0g/Es2sQ45cbBwbV+
         ovX+QcTnqB4V8jKN3QksKBJoQcfD6A9DZQMNYYyg4SzUoLOjl9/LxUB5FjlQQ0rrBHTV
         jlxWzvVeXx7VB4E7cgsVxFhNOdAeYNMu3MdfBDCNF+0w1WexIEcsgmx5zQDKOougKE+o
         m7yrcm1OS6ZYBCydz7JH21vubBPK723WtK1gPbHsXxdfjLFq4F7Gy7gCMzy/0LaAmCPh
         X/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984085; x=1775588885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODJKUE42J6Rz5kvZbkeA/0a+pxH8BWcdgMi0Zx2VGmY=;
        b=ls6fAOWm1YZUWKu2247UO8nmJSW32Ug4OjETTZuSy0UVF9aK7RM4ZrTebPqhfxLEh/
         S40WlUcbCBhsCj0UsfrszI2oPHDipDIPkq431lLN4CoukaBrWjgWGoteYXqEk8XxH37k
         7tOmKB84je/ndB+vq0r81NIwZ3NA/OisB/819bRrr3gjAFZIsYCIYEpcnQFyBfV/+Ut0
         TndiBXYqBVm1S2XJzpSCfNAxrERC16lPT/E9JU2YbRmvnGOXsJ/QmGu8pNc+XjVU/Rv/
         PDoQDJ1SANLTkXTryCoI6RCfgf1wLxsMX+RT6GUzuZB1MrSSQml2m6jVW99VwicSUZkv
         LJIw==
X-Forwarded-Encrypted: i=1; AJvYcCVsuFx+32AhIW5dkCNREwFz0aGEHRTwDJ+5rkM+qkFjXO7bDC+Kza0x9W9x/9jmFoU6J3SLGzlWmdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyugx5DTWGPLq3EIPu6s90kwWtR1AERKWsGC21huhs46y+IgwTf
	LEfAkoytO67qCHn596/ziBMLi6rrgCTwwcGioFLoAOSxZxiG6+XPlhUN1xEAP7SIJadUaCH6xyR
	MwYcLsR80xGQH6aeMFtHaqGoeiYwxGWw=
X-Gm-Gg: ATEYQzwe1dVKPKQiJ6qRxFhnYU8aDCey1LoR/2WeNefilWxSnO7q1oWu4MTonLP4wxm
	j7rSwDBi7y6UV6EQVXz2l7DdwPycIOmg9YQZzUivpkB9AOwfUNiyOqNEtbPcIPMaIowZJ+fa0oG
	mkTzt5+xwaK8DONvEEevjbaWj/u8IDB9u4sYIfKMQa0PH7/rFuh9n793Oi6YeCVZ4jxCN5kfzkz
	wmVr1doqhE2Ktx9zsJQyCAbBoD9b5D8b8+wpkMiQx7KX1bxkj88tJA+daGU1iwyY0ygQSoMAs7k
	HSKP4OkTLH60I4i0k2Zh31g5T9EF4vVJZEurVWqcSLZJmkLHWVI=
X-Received: by 2002:a05:6122:80aa:b0:566:341b:4ddd with SMTP id
 71dfb90a1353d-56d8a64f111mr484576e0c.0.1774984085028; Tue, 31 Mar 2026
 12:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn> <acwZOxbEJoAJrvGb@wunner.de>
In-Reply-To: <acwZOxbEJoAJrvGb@wunner.de>
From: Han Gao <rabenda.cn@gmail.com>
Date: Wed, 1 Apr 2026 03:07:53 +0800
X-Gm-Features: AQROBzAOzUNTpcwxA_0dIdIlemphcrqtCbFrf2oB8l5IhJydsZw1imk4dsqq1tU
Message-ID: <CAAT7Ki8_xKTOuX2kjmkfXrKMevxQZcO26jdmExx8vCXnu1_c4A@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: Allow disabling port services on broken root ports
To: Lukas Wunner <lukas@wunner.de>
Cc: Han Gao <gaohan@iscas.ac.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>, Inochi Amaoto <inochiama@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:58=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> On Wed, Apr 01, 2026 at 01:56:56AM +0800, Han Gao wrote:
> > SG2042's PCIe root ports only support MSI, not MSI-X. The MSI
> > controller provides only 32 vectors shared across all devices behind
> > each root port. When native port services claim vectors from this
> > limited pool, downstream devices are starved of interrupts, resulting
> > in zero interrupts delivered and driver timeouts (e.g. amdgpu fence
> > fallback timer expired on all rings).
>
> Have you considered setting the pci_dev::no_msi flag on the Root Ports
> to force them to use INTx interrupts instead of MSI?  That would seem
> like a cleaner solution.  There are already several devices for which
> the flag is set in drivers/pci/quirks.c, see quirk_no_msi().

Unfortunately, the SG2042 has no INTx interrupts.

>
> > Some PCIe root ports break MSI delivery to downstream devices when
> > native port services (AER, PME, bwctrl, etc.) are active. The existing
> > pcie_ports=3Dcompat kernel parameter works around this globally, but
> > affects all ports on the system.
> >
> > This series adds a per-device mechanism to skip port service probing:
> >   1. Introduce PCI_DEV_FLAGS_NO_PORT_SERVICES flag and wire it into
> >      the PCIe port driver
> >   2. Apply it via quirk to Sophgo SG2042 root ports [1f1c:2042], which
> >      fail to deliver MSI interrupts when port services are enabled
>
> I think we should try to minimize such workarounds or at least make them
> as non-intrusive as possible, so please try the no_msi approach instead.
>
> I also don't see why the stable designation is needed TBH.

6.18 has merged PCIe drivers, so a stable tag is required.

>
> Thanks,
>
> Lukas

Han
