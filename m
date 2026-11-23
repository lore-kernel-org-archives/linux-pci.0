Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430273;
	b=2GvzbFjstr5X7STsHSXFWeKD7ou+wkQkDiTc5HecjhONRShMga51BrsD3wpxvenSbAsI
	 E0f3iBncad18tBoFbYscyX0befbVd2nbC49/rQJXfOEFzml4zloOIeMb8kjplPV0+JzuZ
	 /CmgKIb+P0Q43Du6kCiyaFMV041xjlq67UB0iYeZtIeiLqFZky+eTOtBbS57kzMDFZUgx
	 Hka8kJOMZUdD3EWRNUymx4BAP1jAmjT6/aLQxU0OR2KKOw58MdTsxYp5IXzw9wZA5REWA
	 UsMtsz4qesUg27bPvhmd5VYIypSkhklj65hNvevPCumi48F91garnQp8lTayppiBtRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G0HV1O64qAbNeZjJy8Qii05HYbgU3/dVt09OT0X9gnE=;
	b=UCAed8Xs0eTAcBpkEQVsUR3yt6Fq22mOM1LWyyFUzA5jkFX3mUJfJWbYlFBSegJzjvvW
	 YMENvwpQkJ0YoHAP8Bc+njiJl5v7ptgWvMQxui8+eiGXxAd2+/+3cQ1IJ5R1BIVx5zeYw
	 OnCo+8xv4VWIbFVQE6hT2D4SJkTMwZiExtRv82TvXxzcRS6O/lOM0foXJh5dkIPvkP0uy
	 N7SULtpUGSZX3TbqP9Nu1dAAHPKUXZ9XZdRwBvNyHo2pwud8ouZKjNbfyCv7D7R2mnNgU
	 nhzP035DtLIDZKVr96oUIH0WYhI1uO8yU0omVO3544UIdGBrpks5W6kS7wVveex5P6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO7Znppg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3503606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO7Znppg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3AE1F000C4;
	Mon, 23 Nov 2026 10:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795430273;
	bh=G0HV1O64qAbNeZjJy8Qii05HYbgU3/dVt09OT0X9gnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iO7ZnppghHW+vAlYPYozqptdgd/gPp1wLylZg5F0uK7IY9At9b3ZL7ecDWM/c+YXd
	 DoyblcRlOk8NDO2C+Ex+e+ptAMFgtsp/gj3siL5o0FS8OzphsvXhKCuZz1UH7KJ5op
	 60SBXH0kH1is9UlEAbdGtyl4dPQRmnWOrKT8VTmtwNiKH8xtTjSSzjPtnkzPQ9FJ/m
	 OnKkfjaR60uNYAVtvA99oEMwNm8MUgXDHRl8GVtgu3MKQ2q82gFxp1fqG1XZaDXC2Z
	 X4PpQkuBSxfhPNCQdOVMEOvLZ0xXF/CHKSoA+bdU+IkYxp8fZt5sQN/ABGcjmY3oJO
	 I8gzO2IvN2gPg==
Message-ID: <sashiko-outbox-229058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 0/8] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:37:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 8-patch series:

- Patches 1-4 and 6-8: no issues found.
- Patch 5 ("Bluetooth: hci_qca: Support QCA2066 on M.2 connector..."): 3
  potential issues (1 High, 2 Medium)

A detailed review has been sent as a separate reply to patch 5.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-monza-wire=
less-v8-0-a8b38604be6c@oss.qualcomm.com
