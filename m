Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244594A0157;
	Wed,  2 Sep 2026 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356902; cv=none; b=r7e5iO3fNoGDyT3KRoh57lq0BsxpRhIG1W81/WJDyCWwHet0kMacVZFExwNUpNxJeiiTOQ0T2wb1LnNsDaduCKFf3sDQG4kgl0pMdDHrg8OPn3kM/e80zoHMEpAIMpq57Zbg7XT7gAs8qFQa3MAGOmeeUnTII9dBANB4aGkmGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356902; c=relaxed/simple;
	bh=I+nmJ/E/qJsYHcAlXTkZUcXwhi5VWQkzMCUXGGwM4yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CAcCfidoqy7IppefwH1QWHV6ddqnjl780+WWPGk4HpXYAjtAVM3g3SnHCfDsC969wBh156O3nhFBTL2hmOekPC+9YhZSfjkZ9XRi77dXTPexfk3WqTD8v0yOl9uaFW8050SDzDnSSm1Kvx2jdxNJs6Gk9fts7Z5x5BDOj5yjU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMsF4tWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMsF4tWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C351C1F00A3A;
	Wed,  2 Sep 2026 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356901;
	bh=I+nmJ/E/qJsYHcAlXTkZUcXwhi5VWQkzMCUXGGwM4yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMsF4tWib63E1/VnKtuoJuRDICVrc5JvhS2sQU/ULmb7ombnK2/SLBUi0WWlFT+pN
	 TPRwArunJmSFqoXuS26DSzItX9hf2mU4XSSQha5EeZEi7dsertWucIIj/kuoOzzycI
	 yx9AATaUaSsRrlQuRZELkKAG17S4X6jARbxDkOJUen09PfKhTI1KUTmioe/Jbdcj0W
	 uzV4qtqR5nYxmrAdAkaEh6460mypgdG/6mzeBkWCAxF3qYaS9ehG7OOTDt3MrVpLHv
	 +zB5ThdJo+edm9NNIb39fDy/wH9Ost3o0PYM4jkzxD4+uzzvZ7/rvdLPZGVo47/2zo
	 BLFT8ObBnEVAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 1/9] PCI/AER: Introduce AER-CXL protocol error kfifo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902133933.2992457-2-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:48:20 +0000
Message-Id: <20260902134820.C351C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL VH RAS handling requires the AER driver to hand off CXL protocol
> errors to cxl_core for logging and recovery before PCIe AER recovery
> tears down the device. Introduce pci/pcie/aer_cxl_vh.c to implement
> this handoff via a kfifo-backed work item.
>=20
> The producer, cxl_forward_error(), is gated by is_cxl_error() and
> enqueues the error source PCI device and severity. cxl_core registers a
> consumer via cxl_register_proto_err_work(); the consumer drains the
> kfifo with for_each_cxl_proto_err(). For uncorrectable errors,
> cxl_proto_err_wait_for_empty() lets the AER path block until the CXL
> plane has finished so recovery does not race device teardown.
>=20
> A rwsem serializes registration, deregistration, enqueue, and dequeue
> against concurrent AER IRQ threads; a spinlock serializes concurrent
> kfifo writers. is_aer_internal_error() moves into this file and now
> evaluates info->status & ~info->mask rather than the raw info->status,
> so a masked internal-error bit is treated as not-set. For the RCH RCEC
> path this is equivalent because cxl_rch_enable_rcec() first calls
> pci_aer_unmask_internal_errors(), which clears those mask bits in
> hardware before the AER status is read back.
>=20
> A subsequent patch wires cxl_forward_error() into handle_error_source().
>=20
> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under the CXL
> entry.
>=20
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D1

