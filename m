Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEF489FAD
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000395; cv=none; b=HnBG52E+4fvMOmS9SdztBlzupN2LIISaJMfA4rH0EExRzNhHsqHC3IeWAnqb2KsrNtIS9br9hs6y3zJhSCur4RcWGamuiLFXq/uaszYwcRFQj8OLrrWoJ71Znd4xa7yb15KfiC0JH6QYjArmmovHAkPCKJI7zxb0n9cjZg4RJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000395; c=relaxed/simple;
	bh=UMEuW6KpdOXc0/Oj54edbSD20CsC6OB+ZqMGwLXxzMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=up5YiUx7rdz4ZppyiyoDp4sbFggshKEmTgylbjRPwvcLlb6SSs6v0Ek/UspGPvdfyPGZxAGqFjRtqSGh7OhxLnZ59FmV5r1uDDgbxV3j0sKKpKClu47MJ+rQxVrucbHtXQIXyqty2pbJhv01g6m9JQtDJrPg5blPOB+x3/FjSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBwHqUrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBwHqUrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD2D1F000FF;
	Mon, 21 Sep 2026 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000393;
	bh=+IaQVRHxQtyWRSSFBfMLv/HXDO+GYUBC3QYhfM8Ii6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HBwHqUrCIKz3MmueheJNoW+jWDo8EU+XdnVStbUMxEB8dzRm4RQySA0foWdQkyTVn
	 kNw/K8sBKSE6wh24cTbp7acSPfpOG7eTXTo8cKdBKqTrh+IvKGy7nKVH/WPueuoTzm
	 rbt+AN3Sq5+jHb0zCcZP2E54++2odpQWyktyTlpZGV+HirGQYz68CnLUX5fKVsaAec
	 w1gnN6WNhexIaWtF02BoISStkeUDPpKo8DrPIUBezmiZeT9Ix7y8rC4o1o/RKbDiod
	 dJhwpk0MQKgkw7JuAbOOWOSjvvbnXVqc7ib8GDYcNoiIRnTVLByPLsJ11i+Tp1wztV
	 CQFJ+kE3tQojw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: skip FLR after a failed controller reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haowen Bai" <calvin.bai@ugreen.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921140732.2942207-1-calvin.bai@ugreen.com>
References: <20260921140732.2942207-1-calvin.bai@ugreen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:19:53 +0000
Message-Id: <20260921141953.ADD2D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> nvme_disable_ctrl() already waits up to CAP.TO for CSTS.RDY to clear.
> If that times out, nvme_pci_configure_admin_queue() currently issues a
> PCIe Function Level Reset and retries.
>=20
> FLR is performed with PCI config cycles. Those cycles take
> pci_config_lock, a raw spinlock, and wait for the endpoint to complete
> the transaction. A wedged NVMe function can stall that completion.
> Other CPUs then spin in pci_conf1_read() -- including ACPI PCI config
> from an unrelated device -- and the NMI watchdog reports a hard lockup.
>=20
> This was observed on an x86_64 UGREEN DXP4800 (kernel 6.18.15) with two
> ZHITAI Ti600 NVMe devices used as bcache. Each disk independently:
>=20
>   nvme: I/O timeout, reset controller
>   nvme: Device not ready; aborting reset, CSTS=3D0x1
> [ ... ]
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Haowen Bai <calvin.bai@ugreen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921140732.2942=
207-1-calvin.bai@ugreen.com?part=3D1

