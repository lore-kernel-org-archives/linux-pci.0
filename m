Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5947F766;
	Mon,  5 Oct 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203383; cv=none; b=GKGtXia58s2x6wHMAdCzV++KXZwT+FPqN/f8N1VfFHvajMfdkCYmzUGLD+hyZ9w+cDed4DGIROHR83E5EzEx0pE4F4rmHUOTKjTtX5N96y9sasbJcWzjSQ/okiS9xhVo7pqz2glFYoMzjWuweaoVQiCNsL9A0ja8O5+uL+rRDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203383; c=relaxed/simple;
	bh=HXLKK1gWHI2xFCaBzNh77jS0AFMq5AZupVgOOf0qlFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZIY3ymJ5KwnQRU56nfFJjDJ/Th9M9CJaeP2H2ReUckjWAi7jP9wkJ6HE22RbZE6KqjNqjyxMNGIu2Kxdt54pU3n4sbvxiX9cFwVw/DPuGq6FeP54Q7f8kICOvYmfW9dXgVnIn1XgK6WtVC7kfN7xDGB07i6QPUazcGVv/5KA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Euj8yCyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Euj8yCyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FB11F000FF;
	Mon,  5 Oct 2026 12:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203381;
	bh=HXLKK1gWHI2xFCaBzNh77jS0AFMq5AZupVgOOf0qlFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Euj8yCyVLpSjOnqtfn4Wp3Jhg/7Ewz4PP41XOSKDYpTG69HAG1Ctnaz5JyejX73LQ
	 Nql6RYnLPHdRaPIgRRv1tw9yYeqyxVWTb07bZNX3Ia81bON1njV8Ll5RG4vE1gBpEY
	 MuLCo6NNvCjPtPaJWwSgDYkVOsSCnjoMt6ts7YbcDoLuN1hJ4Da6d5AFtNDOzMKLUy
	 ka3CWhARmEZ+Bk1H5b+ff6RMkDWpaXYsEQebUxFAK+sc2V9BR8It7cCV3U5XatOxwU
	 AYhI6UA1BDIrxTX+X5S4bi+xYVHuuNQtZqYravb/WEVrg3fiJL2Xx9NeNCK5La428X
	 Ucxg17OlsI26A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:29:40 +0000
Message-Id: <20261005122941.45FB11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support for
> getting the pwrseq device if the OF graph link is present. Once obtained,
> the existing pwrseq APIs can be used to control the power supplies of the
> M.2 card.
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D1

