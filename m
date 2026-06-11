Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEC3AB292;
	Thu, 11 Jun 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209563; cv=none; b=qWTYDeG38H93O7rx55AefTh5enR+L3GHBarbzlSetwBPJVGUR9brTNrRLZ7id73BY29jYNmxWl+oXhgMmMEFnQcQHwbnUKEchlfFPDol8PoMunndoQHCn0NmxprDF39SULFk8egFSVOeuWvHIfqL4oGHyg6z3BGxRm0HVo3Hn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209563; c=relaxed/simple;
	bh=6zlJFN/HEpTR8xyPqOhnp5pwp1s2MlWgWJgNeE8EIsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cL6kaCmJuU/Y+tC4YWg1yIgfmiQbv+eArqnCXd2hEZ6BkiDAPWUWAV+j8XZY4LokxNaLVZHpLOkVFbZdgknsb+llhAxCVbbpn5HSJB5lqK29xM+PW7mPDU9czVOSC5TLhwVpZwyQaoAMl+qGBTYqwAZ5aUqZYHyIcqFhB/zqwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU4stwrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU4stwrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E8A1F00A3D;
	Thu, 11 Jun 2026 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781209561;
	bh=6zlJFN/HEpTR8xyPqOhnp5pwp1s2MlWgWJgNeE8EIsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kU4stwrdrO4l804v7P+zWiqrpd2FJ26/yFu5rvOpDSDRu1wG1YBRn/Yees0sQPR5Q
	 NmbcIFx/FxhnjK4DNdYGv/rgcm52FES6aafKVdDNimcK2Nbgl30W3cv4GiY9yJ8+nb
	 6SWJXO1eR2T+hBPfUhM4PWEB4zhfTn1Hej2LhaFxCIQZ9Vr6zQ9kJRwJJgPmHGsNY2
	 2uL2BKMlLeB/L0lFSIK/dI+ZPWnyoNO9GaSBI58CqfUhQ/lY1LQ1LcFmbzFfwrVumr
	 E2e2ms5Q0HwbSZ1KZx+BP9ddodkxAS1YXf+Ln1CB4mAb1rxGPT/F/CPlYZ+pYYHXOn
	 A6aruCo5vUZ6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260610193158.2614209-4-zhipingz@meta.com>
References: <20260610193158.2614209-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:26:00 +0000
Message-Id: <20260611202600.E1E8A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> wrapper for importers.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> the importer requests the namespace it can emit and the exporter
> returns the matching ST/PH tuple or -EOPNOTSUPP.
>=20
> dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> when the exporter lacks the callback and requires dmabuf->resv to be
> held while the callback runs.
>=20
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610193158.2614=
209-1-zhipingz@meta.com?part=3D3

