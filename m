Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60EC3BD24A;
	Fri,  4 Sep 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537081; cv=none; b=Ctb60RjSsiulh3ThrdSoh2UzKk1yZQfTvIJhtOoPalwg41TFUwZtGNQ3IyRuUnlMPqJUCL5jcM1N3ui/QBKenjjbN8mKpKLys+LQkaI1AOOpJPjg8vvIoiegij9aH1uAuiHUMxKwe3mkl7wD+TfatAbRQIWCkSkQyKQNCfURrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537081; c=relaxed/simple;
	bh=UXNaJBy4O1vi/qywf0CvdJpf5YIq7qy/wTdJ9Hz2tto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ExwDfGeuoGIPEvzNXG57v6YA9+RHEpXF+zvLYOEabnK1w2Z5Qlb5qp90mIqDdxg2Mzy1wZC25K16MQW8Mhn7IDVQ1LD5YvjeVQvEJ1Qqs7OVPMdXz77su63qgq5N6C94XYt1scc3l1u1pJuERhxoXz6KnUNG5DmhVuwXpCt9480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuwbKbjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuwbKbjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63B01F00A3D;
	Fri,  4 Sep 2026 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537079;
	bh=UXNaJBy4O1vi/qywf0CvdJpf5YIq7qy/wTdJ9Hz2tto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QuwbKbjz/4Ss7Ykb43Lzn7BT8RbTxmA1ZBoVy93oYBD7pO5hT+DO+S3V4hhqOJ+XI
	 P3K1eQaYCuG7UiZh4hgl7h6kyOlyLZW2uP00bmLl3guUSIE/MxGXayjt7HYsPPdIym
	 PU+8AhxoqKogQLJddm2fgTP0KdvH/D/8HL0TpVbeasqGh9XrG5AIIGUwzjlour9SA8
	 FWuYKZQb6d7MOdXGvRTBwdY8cxEk2QM2opUtaqjew16zeQ2Agc/C8Uk2Cm7qoUt9U5
	 ZlCJKgDwekza1HEUB9pOFnloFBmVEDTaGc8mfmL51IJZklUDYszWN1fsG6cndoiZvR
	 2RfurmG1kJ5yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260904-monza-wireless-v6-5-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-5-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:51:18 +0000
Message-Id: <20260904155118.B63B01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
> gate the respective functions. These GPIOs are optional, on some boards
> they are hardwired to an always-on pull-up and not routed to a host GPIO.
> In that case the corresponding enable/disable callbacks are no-ops, so the
> consumer cannot gate or reset that function on its own.
>=20
> Implement the .is_controllable() callback on the "bluetooth" and "wlan"
> targets so that consumers can query this via the pwrseq API.
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D5

