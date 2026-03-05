Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990A21ABBB
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772687265; cv=none; b=XlSaYI7u586lmN+k3cw8vtQ2z4Gh8S/qmh+gKlnTvmwnMw5gLbEJvVaxf9mrSP4RxgJXlDL3ZvH1uz6N4XUT3tz5+sFmbnxhqnfzfIrJ5Y1rW0WGe4rjaex/mkUdVSFOo5FSHbhb7UuxCpz67jzf94L+vrnHY77igb464DVc6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772687265; c=relaxed/simple;
	bh=nVFutvnHX73DBlbJk3FOXoKmPIfgV87F6luvH28Uy3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN3VTEbWTVV23wUNOTE2l0PNnod2DK9qSWNd9Yey3JavZ+MXrdMNkvN3N01Tgc76qfN/MLXM7j6dLGkoMSkP/aHizHnYYrc6LAAYnYcrCa7VCXnS0t7VsHH1c9xqcNWri5wpcXWfNZ7WqsD6Dgjav+dT+VNQLxcLPUApFMHAHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Om4gkZ; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Om4gkZ"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffa0b23a1aso767423137.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 21:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772687263; x=1773292063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AdZmXhXnDlZdyTZS1Hc7DYg2ETszFmyndF++qZZtg5Y=;
        b=J6Om4gkZzwsIWVvH3w5cFDeZ0Pxuubo41PV+mfBJ2aoTiYMy1cj8FxoJSwJAtMJXxW
         W/fGITxNCR2ccmzK1toHg62bWxAKD1XWBe5W/yke6kf9LGaIa7s69plpJjeV4I2A8fA+
         MBoorLL8TtYl48cq/AIVHtRXcPBhBLbfcEvi6LAClNBOaxVO+pHUAsuuzXHDJ0MO20tW
         XlKRNGW1TW2GVbl8LBQUNgEdmePleHE1Hc/f3aClWSAhdDj8OSYP36bPb44v2un80R3w
         MSzkGTb4mKNEVQV8W4JY63WxeZsI9tLEInYWUE6ZuDP40DulbmdZudjJH9vImXR6moAs
         OT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772687263; x=1773292063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdZmXhXnDlZdyTZS1Hc7DYg2ETszFmyndF++qZZtg5Y=;
        b=RkKREhMFukGOpcxjWLfZMpQ+c1RsEzRfwoe7oflqz78ARQn3T/AFG2svcOXIrm689y
         Qema7SZujVoSNkWx6fpDgh8Dg3aDWNR+k7xIPsq22/oxYJGGN+xSjmCieH0FOzEQi6z3
         tfJ6D+8z0Onl1VC7AtCkqyWKzJznxUtpbUQH2/YNZWTUiglRIdwf8hSw3c3SvPPn8y13
         y487cpMWr+YrmKE0XOOEUyNgAGAgdUxXjQsvkw8dXCKC7vCmxOinauoYDb6qDTyXRHPe
         un7sJZI5mtDLitASO7q9u9H0FxjTf+phP9pIowM5zYy/9RDfV7wi2rKGh7fcEGbraIm/
         XvFg==
X-Forwarded-Encrypted: i=1; AJvYcCVAwHrA8bt+7i1ZWr8RDqOHQ4gGiz4P2rP/48/P5K1xrNQtPvecSdqaqo3BW275Qb/YkcOSMHbMY0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6nzVb1HcTOYcGlN4tiHHYdSiKVftls9vPmi9sVP61D1EirnJ
	JmxSqR1GejIs4/LMpQt2e7Rtg7B5Ie0DBADHGF1NYJRFUpF9NGESYtm6
X-Gm-Gg: ATEYQzyeA+NDRDCNFbU7Ew+KvdS52xgCM4C0tqf5e5w+/rYHRj1p/B5Vlaq/iNDzDW6
	E3nMhCufuBLx3JBKXaCXp9gvhrqw+HYSTClvrh/NsMyb+AvH9WoV0GR15olj5VGHNNl54U7TDYn
	xCMODD7vpzcqcn3VRkHEJVHz4dmzpUFrLpvj4zS9QHuBVg1KzT8xePMD2XXEUMcj366eC1kLLfr
	GPYeu2rzLZ5LAW84mPxyBrkq+1kPwg36+EneChblUvHoV7LHQQh+AvfWloYox3knpqtzZBS5sXy
	SXl03VJY4ff65Yhb2FMw/1ZMiTv75mXzF3dCfKvAKseQgQfcmiGyehpWeKAo+T3d8tdozSGhMud
	vQ/eud1lHK6ar02+H8Sq2R8MUV4fht8k75HFsRZsnU0bg+bLO83LTG+RQFnufqKcrBYO89z9Ufo
	0=
X-Received: by 2002:a05:6102:c4b:b0:5f1:70fe:3027 with SMTP id ada2fe7eead31-5ffaae99a69mr1529688137.24.1772687263133;
        Wed, 04 Mar 2026 21:07:43 -0800 (PST)
Received: from geday ([2804:7f2:8080:fd2e::1])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffaca9c848sm4177694137.10.2026.03.04.21.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 21:07:42 -0800 (PST)
Date: Thu, 5 Mar 2026 02:07:36 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dragan Simic <dsimic@manjaro.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] PCI: rockchip: drive at 2.5 GT/s, error other
 speeds
Message-ID: <aakPmB9-A0yS8qKM@geday>
References: <cover.1772239598.git.geraldogabriel@gmail.com>
 <2a0a4aa97bb8b0cb511cb651c5d66c9ec8bab97a.1772239598.git.geraldogabriel@gmail.com>
 <d2b91260-7666-3606-69ec-0e7cb7a48c02@manjaro.org>
 <l3y3isas7rfe47uwk3bcvx4qpkpfen3j32omy6r4rxe6kn4kas@c4z5ydkervkm>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l3y3isas7rfe47uwk3bcvx4qpkpfen3j32omy6r4rxe6kn4kas@c4z5ydkervkm>

On Thu, Mar 05, 2026 at 10:18:34AM +0530, Manivannan Sadhasivam wrote:
> Patches 3&4 can be squashed together, but the rest should be in separate patches
> as they target different drivers. If we were to revert any of these in the
> future, it becomes easy.

Ah, OK, Mani, thanks for the clarification.

Geraldo Nascimento

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
