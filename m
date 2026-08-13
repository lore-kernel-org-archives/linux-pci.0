Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04F3DFC8C;
	Thu, 13 Aug 2026 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599125; cv=none; b=L9zRTKQA0fN938sNyv6a+k8lu7alUian1Wp5mf3UZiVjZOPdlRUQRO7XD1tpdRimTIwHXl47farIseXtnb774VRF9VNVnk4L0Xpj2hwAlSeSfjvK5pY5b3UY9Cdl9ebi0PW7KQ4XWUChBKtB/Q2FU18sWYryeL8C21BuLXi7x/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599125; c=relaxed/simple;
	bh=QXvYquWMqcudevGlK7VpC9xkHfIZG9bGPfmBUnbvZ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbrkE3PgA4EyklOvCwQlwt2rhgaNC82JU0ui7ZpsMi6eCdpHxg0sbWyXK4zqLkUynFgFEyJ+9HSPPWYgDRlftj39TPdOyiTMUwv7Hc6OsXNNK150QREA4rB7EU0L5A1Ul5b3LRDSJ+Hn7g+5IiAGq9DR+aFL94CTPswZhocPNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuVc1WpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuVc1WpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C980D1F000E9;
	Thu, 13 Aug 2026 05:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599120;
	bh=DLJfBO2G40OWzLwwxKFSXJTvkr9EzDntk9qp9Ghfjs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AuVc1WpY1T6bq/8/8id/AclZBsRPdVWHX4ujGKWhx1kxXft+llsv/lKJ/+HGTUo2z
	 A1m97hiRB//0h0zPrMSDFwFkzcF/q7FwNr19nJNvEngzQgBtRLXTMOtZgceI+bBh0A
	 VKu3O7L7vGfYWSXidQaSE6XFLletXB8mH3ClvSsSDYrrZPocLIzgfjVwRocD9I8Jdv
	 LWsTJTqHh1eh07oWpFRYfihd4vHySqMjRHcJsUXwg+zRfe8FvQPIbzkpCcfrYfH/NW
	 FLYCEWAWSeSFwpZiymnfJ9YXZ+6e+OLACMsMLOA0M45oj/aBWsYq11BLICrcEk0oY/
	 //7S+Lr3kyp1w==
Date: Thu, 13 Aug 2026 07:31:51 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 03/11] power: sequencing: Add pwrseq_is_controllable()
 API
Message-ID: <pacoomcusygcdszbt56scxj7kkdzwmv25pvqulft7scfdshwn4@2dgzce7zvunv>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-3-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-monza-wireless-v5-3-69ec6743543c@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 10:04:05AM +0200, Loic Poulain wrote:
> On some boards a power sequencing target has no host-controllable enable
> for its function, for instance when the enable line is not wired up to a
> GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
> one such example: when the M.2 connector does not route the W_DISABLE2#
> signal to a host GPIO, its enable/disable are no-ops and the consumer
> cannot gate the Bluetooth function at all or exclusively.
> 
> Add a generic pwrseq_is_controllable() helper. It reports whether the
> target's final unit provides a host-controllable dedicated power actuator.
> The target can implement a new optional is_controllable() callback,
> reporting whether that actuator is effective on this target (for example
> depending on GPIO presence). If the target does not provide the callback,
> it is assumed to be controllable.
> 
> Note this only describes the target's own enable actuator. It does not
> imply that a power-off reaches an electrical OFF state, since a target may
> have multiple consumers. It also does not mean that power is uncontrolled
> for the target's dependencies: those may still be gated on their own. And
> it does not restrict consumers from calling pwrseq_power_off() either,
> which remains valid to drop this consumer's vote on the (possibly shared)
> resources and dependencies of the target.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
