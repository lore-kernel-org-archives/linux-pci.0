Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FC3F5BDB;
	Thu, 13 Aug 2026 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599257; cv=none; b=Dx2nNq+/ZwJ2EQny/7P9kx91cbiUxdzZCn6luWCZHvG4VMAHNgVaoTkKsVKG9IV4t/1BumLX2xlVVH0kR02szg4rSBcWCnRPW0J4/HhrMPdsj2CizV5cj9QLVp7Rd6QZ6EohF1Ek93sycGPzKF9HD0/YLbJdRLPomomMmkxi89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599257; c=relaxed/simple;
	bh=N9RPka2uXU7n5hQjlZpP+81d7WGcwlUaUhmWSdWYFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK9qjIosWyFFdY0mxxPNEg4siLkr9BITuVYHxo645+U4o3OrYChEOLDFWOVzRAcJAHXIZRyGhnVvWxuCx6jeJ9Lpg7/tHNV2CbIEoX3xmAgrmLXlgh5msL1yw3CmivetrBSvQb+g46TRncgoqKJiaXoi785IGO8D2t0v/9VXpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/VtfZE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/VtfZE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629381F000E9;
	Thu, 13 Aug 2026 05:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599251;
	bh=DwRMhKXscDokGJvrUL9WdZpOZUzQ0EylQXiCkptByQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/VtfZE8JAG/LS2XBzt5fj/dQ36Dg8TtJ6S7BgYN/+eLK27SKRQM9UB4XyaO0Br6+
	 vysHov912Ysr8yt2r0ovh8GN2c4gnBw5QgB+6IBzJZAGxF64+o38bFOD788XKXHaEv
	 7TVL31NcAtf2gvlaNOZjweHNo7SijoHPAG+DaOV7d2lw36zIQJAZcbzzEzDDc0ENkj
	 rCXEK08NcBvahaJgUbtYkaLL76dZvo4IMH45GoJZnvCUGb8U2ja3l+hwiT6VlDtUS+
	 2fvm8VWcpFOmUef8VpAkm6PsgKDJ8sSXMmPyNZcr+MLVRtp9P3dRcESEgZr0ZTAxZc
	 C1j8KwIeaAlZA==
Date: Thu, 13 Aug 2026 07:34:02 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Message-ID: <anjo55lluayxddxu443viltahzbs24fvildpfy7uxgj6rbgx7c@hxebxqczlgev>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 10:04:07AM +0200, Loic Poulain wrote:
> The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
> gate the respective functions. These GPIOs are optional, on some boards
> they are hardwired to an always-on pull-up and not routed to a host GPIO.
> In that case the corresponding enable/disable callbacks are no-ops, so the
> consumer cannot gate or reset that function on its own.
> 
> Implement the .is_controllable() callback on the "bluetooth" and "wlan"
> targets so that consumers can query this via the pwrseq API.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
