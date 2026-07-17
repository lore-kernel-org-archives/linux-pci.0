Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74577246BD5;
	Fri, 17 Jul 2026 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328051; cv=none; b=LE8+5BXfXU9IErtgjV/1nF4k43ucDNcXFvhBeDzpAs9FtsAN5YEOBpNtJnI62numkffhTbj3Ued19TmDI7Vdoezfi9HC+W0rfg2KNz3woDmu6GCrIOTb7d7i1J6eUkKBydqF7bH0yUeSfXKJ3QRhD0VWtHU9uJUcsuRq29k25Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328051; c=relaxed/simple;
	bh=2gY1WRBE9ls91adIqnsuZSO2Dc6uZB8j5G4AGHtjWl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j7Ye94aFm6aXR0dzK0WBCglkdzvabjc7BFrNOpMBW1iI2KXrhIR0WFwi3XYzYuvj1HiSusnQhlZFtijS1jLS/etrZ1te6DDku85uEuJM6mKYzWtqPRlHxIN1Qcmuk7dKEsSfZrxvsPxhixt8paCDTld8HaOVLm30zDzoKl2d18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at7sTrcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at7sTrcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0352A1F000E9;
	Fri, 17 Jul 2026 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328050;
	bh=2gY1WRBE9ls91adIqnsuZSO2Dc6uZB8j5G4AGHtjWl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=at7sTrcVRWNIyIiChID82ZDW5TXruacxK7q/wnSi6/t3tUey16qkVU8PkSnNZ0+Ph
	 wPygVmT65g6a0wdptxC+WGsku78QrCRkC85HloVr+tdJzxe2617795pWZ0BhSqID5f
	 mcnv2/7jQoQKQs42MCj7zT8+tfKep0YLhabxHUTmMgJj7dc98NsvUJgZcFKADX5aDO
	 bbo1OjAJRgeN1BaTgXcmroT/ReYtX+1yk/mUtMeykWO707smOLrwKnzBkM+/Uhtb+M
	 hFwDp05aD6bTMT0IEesZRqQy/iiTEdl5dd6VEnFOQ9W5ILDpep6P1TeZTxgK23C4TN
	 OFdsHv7TfXaAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 08/13] cxl/pci: Thread port and dport through RAS
 handling helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-9-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:40:49 +0000
Message-Id: <20260717224050.0352A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dan Williams <djbw@kernel.org>
>=20
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and struct cxl_dport * for the device being
> handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from ports at trace emission time. Threading
> port and dport directly enables is_cxl_endpoint(port) and explicit
> dport/port branching for cleaner trace dispatch.
>=20
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint(port) and emit with the memdev, dport
> events emit with dport->dport_dev, and Upstream Port events fall back
> to port->uport_dev.
>=20
> Update cxl_handle_rdport_errors() in ras_rch.c and
> cxl_handle_proto_error() in ras.c to pass port and dport to the
> refactored functions.
>=20
> RCH Downstream Port correctable trace events now report the dport
> device (dport->dport_dev) as a consequence of threading port and dport
> through the RAS helpers. The following trace event rework ("cxl: Add
> port and dport identifiers to CXL AER trace events") adds explicit
> memdev, port, dport, and host fields that provide full context for
> all device types.
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D8

