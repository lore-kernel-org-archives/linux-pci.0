Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6B3F44F4;
	Thu, 13 Aug 2026 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599307; cv=none; b=mzZIYKJZQjAKgVsUj8eioK/9DMI6x03VG4FDU2epMQgXyaE2/PU0mIQtkTZTxDJSFxjptJxtitGsh0L700PQZFwscQKWee9n3OB3n+G2cbV3JbF496tEcbWm6tQX+z5TgUIVIFfjGCkeQuV0/xOJJV99u3y3wfHtTOvvTrthmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599307; c=relaxed/simple;
	bh=2TuP6pINHbHQ5Dyp6UeJbSdWQ/KXesL0p05WPqqiL+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVCKLr8s0Ybmky3F9Y6gtzVy5UqenaGF5a2AMXdc59tq3Ub4csKeSaKtwjs6ooYN2XZvTqdON/5XM2MlGYTqK+K/zhbluenilE9Sh8bgNLZiqLBwMBI7e/Ciq+YCJOCPsI3dqIfS7GchmS7cjO6vZZKnuuoi4xVzZe1cWo/bNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4wj8UTR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4wj8UTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9791F000E9;
	Thu, 13 Aug 2026 05:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599303;
	bh=iMwGnuUhq+brxF5vxh2qzW1rN7+wHXNdjyMVyESTrcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4wj8UTRDt3APds2RKovz8i+G9C2bzWzl/dQBwwP5YvOAm7/hSlb1bFchk8QSISfT
	 aL98F6RSpM1Q893C1/kiMmp4BhnwYZ1G0n3VhCoJRkK6zLUVr+FNUZXzKILjaPFJfK
	 zJkysuzbUiz85dx85wynQYs/qys+MholZlQzhWCxXwF0GLN69CJcgWyxtfP/FGeyTB
	 dVryqcS3GUgvU1Yxagc7PTpYWvByO7Yj5VCq/AvSS11WkHE7WUl4Qbs9yT91XU1hj0
	 hQz6P/BojWVD7jpHtg+pw4r1wCPYdJ6ytL09X2297F505P87wm2dwOASy3HVRErGua
	 Wg7ihOHVdquOg==
Date: Thu, 13 Aug 2026 07:34:54 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Message-ID: <fggkksxpo7qcpyxoggnsdup5nrlbj6y47lleuytmchcfs7rmft@3i7m7iwf2lup>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-6-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-monza-wireless-v5-6-69ec6743543c@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 10:04:08AM +0200, Loic Poulain wrote:
> A Bluetooth device only needs the non-persistent setup if the host can
> gate its power, so that it is actually reset on the next power-on. When the
> power is controlled by a power sequencer, whether the host can gate it
> depends on the hardware wiring, e.g. the presence of the BT_EN or
> W_DISABLE2# line.
> 
> Query the generic pwrseq_is_controllable() helper whenever the BT power
> comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
> If the power is not controllable, clear 'bt_en_available' so that
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
> 
> This is based on Manivannan's original patch that keyed the decision off
> the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
> and handles the always-on case.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
