Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87943F08A;
	Fri, 17 Jul 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327728; cv=none; b=XIX8fvCtmf6FNQ6GuSoRqjes1bZ+hETikncMlS04MCYiHi+vx9m+BJx12LtQxZdqpUWa9yJg5S2SJlWOXzDUP7QF5gXf7CMWheZ8wtjfREmMAhuIabR9jaXclzMaenjnuj7mQAiq+8VDAv9v7m2W5ZbHLaGUWm9IpNKnnAzFaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327728; c=relaxed/simple;
	bh=juqaL3eaaRXK79+lHkOL3AwxXKWixjs+O3054ej3fcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jIOaSR9EXWPImJhIr5i3YUuBOOGyZ3kIUyBJzmveHK5nxzcK9UkzT1fIBrfz78absiCEisa1SZn0XsRsOiXtRkz0DMoi2UPg5UDeuRdZRs2EW9nh5j7gvp9CFyqPnNR6ioKOo/sc+MwymDIfhPwcQOKhz/iR0AkmYt/rynf1/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5w3ERP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5w3ERP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC58C1F000E9;
	Fri, 17 Jul 2026 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327727;
	bh=juqaL3eaaRXK79+lHkOL3AwxXKWixjs+O3054ej3fcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5w3ERP97U2POSMx0ukH5c11/bvgJzxDPl+ns+zBjMhl6XTzlj6/eN1SaVeJ03zbX
	 oEASx/SdD4dzkKMxDsYVEM7Yj78EMd78QQu77k4MbLyAm2D0mGdBZaO40xwSZfF3aR
	 nyEQChwZ9AZfctOlo7jVoY9mTioI3E/Tt2fvOYR5eWcaXz9Ff2sqjjwt7ow52RWeRz
	 0y4QXXhcUdRyXC8AOBaQXnNcbXqnHan/YnxTe6o//4gsVMjhHgxUnwkgxEUKmTbMbP
	 vdCcZCMFeYlZr9NkwHsuetyoa0B5W1quFpSnPRXDofvLy8XxLT+NwodxaQB91o5kRD
	 8oWRZoHlaq7hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 05/13] PCI/AER: Introduce AER-CXL protocol error
 kfifo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717222706.3540281-6-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:35:26 +0000
Message-Id: <20260717223526.DC58C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL VH RAS handling requires a path for the AER driver to hand off
> CXL protocol errors to cxl_core for logging and recovery before PCIe
> AER recovery tears down the device. Add
> drivers/pci/pcie/aer_cxl_vh.c to implement this handoff via a kfifo-backed
> work item.
>=20
> Introduce is_aer_internal_error() to identify CXL protocol errors
> from AER internal error status bits across both correctable and
> uncorrectable severities.
>=20
> Introduce is_cxl_error() to gate the VH kfifo path.
>=20
> Introduce struct cxl_proto_err_work_data to carry the error source
> PCI device and severity through the kfifo. Encapsulate the kfifo,
> per-producer spinlock, registration rwsem, and work pointer in struct
> [ ... ]
> bridging code.
>=20
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D5

