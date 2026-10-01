Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794B4A5EAE;
	Thu,  1 Oct 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847067; cv=none; b=UD0P9wHml8cl+LxnsLPlGfa7XIirEuF5woFj7qhUjyyNgi8ei6wZ4QnM1y7E9hKeWQL/s2sJttFuNV18JlfcfTWIb9waEqaf+3a6+oYaWMEkQQhfO9vw5ffcBhTlSO3lDhHNQQOMa1gSJVdSRT0g8OGWMAqY639ZZ9MF3vNLVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847067; c=relaxed/simple;
	bh=3MFEqfDjPVTF/dnl25pXR+Lv+5IGvwSBla5MHOp0NNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UVEKV92Wz1F7JCDVOp7G2i6lBrhSF51iIfXYmVAOj3aRwbny4fHHh82gxZ/EBI1QVd8jBYB6djZCTYRAbpIfr6LAFIeAhTVjSdXOD+VsxdufJT5TkBr2v5HOxIai+vYsPX1JGESSNBVLQSKOg7oj3rHl2nyIC0J6VT0tivCA7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgFhWPMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgFhWPMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26821F000FF;
	Thu,  1 Oct 2026 09:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847065;
	bh=3MFEqfDjPVTF/dnl25pXR+Lv+5IGvwSBla5MHOp0NNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CgFhWPMGh67xyCqGDJqXumjfBr87s4BG34fKvH4JObcly2eW4GkmdkNum2rAIbmF0
	 /I+W3SSQyB+/lqB/X13UqKuVrLl+OpmuI0qBkA4c/z7syLJEvTKJlvH8YiM9iA6MOM
	 1nganZnyxZrQncuC1mC6vExlPYdU/+8E/HCXBXkrUVtSZPsEBVJbUcoEeMV5okWQ5m
	 9N5LsD1qmifHmiMjx9FB0jiFD4NWvG10tOBtSZDNmopIhzFUTZr/aOw5fnCOageUdf
	 s7zY7ER2jhHicHrbeeftkxT7CzHR5jdsOj3WKK0IeyKXCqs1BpgrXtO/qzaft+opTK
	 ppjaN1XmmiQVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/16] cxl: Move HDM decoder helpers to built-in
 resource code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-7-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:31:04 +0000
Message-Id: <20261001093104.C26821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the refactored HDM programming helpers and cxl_rwsem from hdm.c to
> resource.c. Build resource.o under CONFIG_CXL_RESET so the helpers are
> available to built-in PCI code when CXL_BUS is modular. Export only the
> symbols used by cxl_core.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D6

