Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794512122;
	b=x+469bq8bbMSxModaC0qQxizbk8G9adfmBvf4/NEVVso3Mj0EEBGtWd1JW5aTmxfxNZa
	 qfXbmlPCuNMaYhWKaZyDEwnv3NqpbMvr0dF1BpBbcjSKIUZlDUkDkRSSVA/GR1Z4mqIli
	 Gh3xIzL7XWrpWCmUjJDNUzMx4Xhrd9QjPQ3ItM5gGYEUKAuwDbfK8n8Ir1NqKEWhX8EB3
	 Wh1NF7utgh8rYeyc2qXMILnpoBIctph2ZilHW94XzupCAi3UI/0FF7J7P5zaI9Jn/xexF
	 eogrBPtn65pe/hmWv+Nbyx+FLQyiL6dunaFeTi6usH3PhEWcP8DKYkDI7Gz6DO51Z/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
	b=rn8BYHxtRC4Q6pcQ1ElunXBayo/EXh+pC07uIQTG2hovzYfbj3mxWwUC0ENjfvJ3Fv9o
	 FNhbQZ+n7DIZO5DMfIOpnyW4+MkgAGiccaRvTYqyYvUvZfp/MJVm1boXWXvycPbP7sg48
	 xyILUzjcxGQx+WRH9U4mEKU66KVyvwbWHFfBTDD2NO5e4BZTetV6684ppP1aZNSSKCYAp
	 5ZH2pFrh2wWW/QP4i1A1edr5a4BRUxHQwfPb9D1Ls/nLcl4+OgRiESIoUZDp3pMHL+RQU
	 41Yuhaa8Z8p7rSAwUxxyxzxl5IYfjvy1L8i6SSjItpvmzUeoGeH0c8vLs75V61E2EcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOvkPnaM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7E606A32E
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 19:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F7E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOvkPnaM
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93cc1ab5f6cso17490885a.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 11:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794512121; cv=none;
        d=google.com; s=arc-20260327;
        b=rnvjIXGI8qZPlHRbTpvJDfr0Z53814IsT4PyzjmxoiHvDklqXN6UBLi4q8GPD9YZy9
         ERybc5/YrCZDfKpxbXA93QUhtsgrmjeRpxOGnZNKp/8JvCGB03H4BkICcczPMCXqXJLs
         mIPrm/XIrEU/ctLwI4q0WMBCX/krllTxXq1iXkj5k/K00Orr1X3D+JXjA0vOs0Y4EVAa
         rbKm56aPOKntKBcaM4ewvuxL5hiXSctN+hoHyMK5yos4XlSMMaf4Adk7jo9E/i/5T8//
         IQSGUcxXMbgON/IEtAtR0WRs3qDVVLc3gBjSn4wE1YEkNv9QfTY0HPzxT2DJAHu35j7x
         z0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
        fh=t1scSvpbA7bbk9tVeerzH74KpIcLCbce02a9+v6BoyA=;
        b=mMr/fAyR/5oQs5XwGig7wbchQqma7JkjLCl3oPvr8czi4YeeeYMBgNfi/OzGi1CStu
         m0+AXyeC86ocvYAU6XntAEJmq9CNjvopxRuY0ev74tn/xL3gijHd5ENIzPpWFYAPMuQO
         Ep9l1ACulkBub9+sV7tqTr/R0lgc0gtLr5epM3o0lAXK6WveMQw3lpKo0uIyG9wBhyLl
         PzPLkuA2tICGg8HQzFHxlhuYt0I3Hw90I4yM3usr1Ae87iy+FmQQHfHA5kr/YwS5fJo1
         DfFrB1PUnoDeQGW6tCusOoWgK3c2gL1XEcuK5D74eYadSlDTd70ObvPBI010oGv40ltB
         3LZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794512121; x=1795116921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
        b=TOvkPnaMiidIptAqmx2zbHxBFlHMqub9g0awZPe8AApCcNpJI4EHLPHNn/Btko25bN
         yLD9q/OHcEcJXEliYbDkVyTch9+v9kpGdAyFgvsEHZfHq1c1vhkqBQ/e9hFBjt63swpc
         5X8ISVDqpZ+LwEejsfNpLmmA3+GCryC6QocmXY0KdF7iFkmnKxGykVQw7Ro5Tm+ONneg
         1Mja5JR791Ia5qx8inHr+7iGE/PGeHetcMCG7qdoKc529QyB0uHfQUtifQXjKpEtq1VD
         0Rfkb2hvBiEApezIco8HGFa383afvQlTVuDOMjLy0ao617zfk160mMrKMrRGab8DP1me
         ImuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794512121; x=1795116921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSq411+s9NdWoKtVDUAKy0Kf3U5pcLNuZimkjP4e+Hw=;
        b=b6k+Sh/phBOTui8fTpAMxJ9+u3DczxkPhkfpvOYIJs5iEKT+KAHV4p8TlE1PeR7kdY
         ypmx/bpgPy1PzufHXJJiXqhcvre5qAUJuXHo+4r4Ee58bX8sDnjs47Tsa/NCf5F1Y7Ha
         DSKiSh2ehQufsQXMA5bVE8kUzYCP3wZWvjf9KAGhQu8+wsLe9YlUEeFoLlWXRTs34TMi
         UDCIV/C43TmQnvs2cBH00TX6U5VqwYWfO1xzl/lgqsQAumIhushIrg1RI+j9omEQMFqD
         bNJioesPwOFBVmeRArRw7iEZexZ2vAywjYsBXt6PBENgShU2r6vxpDdXHN2c/nTkOynw
         OETg==
X-Gm-Message-State: APuU4Z/hmYzaPDpI5suVHSHHGZIz1Hi2szlXhMEqqEukTX0uEjX498h/
	2H6aSlETmjZcrii4CONoTuX9YFa16Vtr/v49nRTq7+/bxO5OwSmRdwX3KRvS1qOZDyoU77rPXAf
	RE7pA6MQ/MW00L9HVMtpp0DOUBdTmEzs=
X-Gm-Gg: AYBFou3L7a0T0uIQDKrywCAFD8ILudfKJb9fog10KMxt1vtKADmgOzoFQuzug2avZ/B
	azK/AZQQgpmdFncMWh+V1ya9xzD+jFAVoaH+otMAckr0zHvypnlWJhy8TimYZjcAdGeti9MtdmA
	ig82dzSqCP2ZaApq0x7YkSJGtDmh7olk4YxUarqqfpH7t1eJcaxCPM3vJ+CT0Zxjuvcq0qqH6vh
	cmf4fy/kE+dRTMOuZjRyaxC7rNFvTFC3tlWpjY0Cj/bN16cg7cW66wXDGBKc34owgVc+motesmP
	vhA+DLOFpFrQKiR8oy3QuldBcQocXhM8JATDsOJWt/54odayJSgz095iuapYHHJiCVpFQO0YP0A
	mTzWqIBkocIitE2XLHZ57WjMarFH7Sfd9zUerL5RfFEsLcUxLQWehIzKgWIeIQprMeqY7URystd
	/HVzkRNZLTPJAx8WVW4Hj5OP+Lx5rhm2V1HayLtg==
X-Received: by 2002:a05:620a:1b81:b0:93c:c405:3215 with SMTP id
 af79cd13be357-9494bbccd6dmr77956685a.44.1794512120789; Thu, 12 Nov 2026
 11:35:20 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Thu, 12 Nov 2026 11:35:08 -0800
X-Gm-Features: AclHuK_BvMs_YVdGy0WUpg4okUuBQygcvvwgCF7Igbxb1UybigcTBxXa87y20ak
Message-ID: <CADvopvYQDLx81gDFNR8MAg9E010K3yJNEByAwawQHFahRYiXzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PCI/sysfs: Wait for config access lock in sysfs attributes
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:20=E2=80=AFPM Matthew Wood <thepacketgeek@gmail.=
com> wrote:
>
> Many PCI sysfs attributes that read from config space are using kernel
> accessors that don't wait for pci_cfg_access_lock() holders before readin=
g:
>
> - serial_number
> - max_link_width
> - current_link_*
> - *_bus_number
>
> If userspace attempts to read from these attributes while config space is=
 not
> available (e.g. during a reset) there's no telling what values will be
> returned: All ones, zeros, or garbage.
>
> Looking at attribute addition history it seems like this was an oversight
> instead of a specific decision so this series tries to resolve the attrib=
utes
> above to match the sysfs attributes that do use user accessors: config & =
vpd.
>
> Patch 1 is a prerequisite for the rest of the series. The kernel
> accessors these attributes use today skip devices marked disconnected
> but the user accessors don't, so switching over alone would make the
> attributes start sending config reads to disconnected devices. Patch 1
> adds the same pci_dev_is_disconnected() check to the user read
> accessors.
>
> Note: That check also affects their existing callers. On a disconnected
> device, VPD reads and writes, VFIO config reads, and VFIO writes to
> PCI_COMMAND now fail with -ENODEV, rather than returning ~0 data or,
> for VPD writes, timing out with a "firmware bug" warning.
> pciconfig_read() fails with -EIO, and the sysfs "config" file and
> /proc/bus/pci still return ~0 data.
>
> Changes were successfully tested by continuously reading sysfs attributes
> while a reset was issued.
>
> Changes in v2:
>   - Patch 5: check DSN read errors in serial_number_show() and return
>     -EIO instead of an all-ones serial number
>   - Collected Reviewed-by from Keith Busch on patches 2-4
>
> v1: https://lore.kernel.org/linux-pci/20261025000836.58294-1-thepacketgee=
k@gmail.com/
>

Hi Bjorn,

Checking in to see if there are any concerns with this change or if
the premise makes sense?

Regards,
Matthew
