Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635873033DF;
	Fri, 24 Apr 2026 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025725; cv=none; b=Z2CrJhGP4OjN3Y2gOrbSdghLlrBbnuOgkYR1NMhdP08ZdvKSuM14gsVZUzDIepR0WmtmLB93KutiYMKDC+68Lj+F9Rho/w2KWuLCRGwXfRhIR2CNwAna/JApAadlCUU+sBWo4ixyoNQqiFfjr4OXSWx1gf89dxqtU32PrpRK8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025725; c=relaxed/simple;
	bh=eCvCjPF2iNIM6v2y0tCDFC3F5gTlmXCCo4qyC79B9WU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qiCKxhp46g5G4BWGUKvAYcth0q7dH80hjAO0o+BbmXj/Du8hu/vD+q6qm6d7Xhgat6A0cBQEYhWl63Ech7el3MKPlFV5gPRR/EMP2JTBph5oRBmQIVn3Ko5j+ZRfYZG7L+TQnKYVzssmNN4Q0aOcpxnDsFyUcUVKiim1Aod5eLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfMyI0Ej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfMyI0Ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DBDC19425;
	Fri, 24 Apr 2026 10:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777025725;
	bh=eCvCjPF2iNIM6v2y0tCDFC3F5gTlmXCCo4qyC79B9WU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MfMyI0EjlKYdEH0M9oftNtCkK2cCRxr5+rgYselnUyQjM8EsghrWInkRDMknzudiB
	 a6XW2bwcrMsxQDzO9f6KrfkI2RC27cSnCNWqYUcB0FEktYi3EhsGInFdDkTmgtzKXg
	 6nOQxErPbdhQ79FA7HdhZHZhY8CtRBvoCkIxmCXkEmEphxCJPfAgxJodMxjq059JMq
	 5jNcqVlZG+YDm6IEkBne/MP58/DkCDuTt8qMWWoXLXI9hf9+cSIBbnsHKRQlt9+20F
	 zu+SXDKSOnV7PZ8NXWgh100QXKx48AWktqiDv5vhIGUF6mCwdyumfS03PZw8nHqVU/
	 vALED7HXi5HEA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com,
	yilun.xu@linux.intel.com, bhelgaas@google.com,
	alistair23@gmail.com, jgg@nvidia.com,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
In-Reply-To: <69ba57199b38b_7ee31005c@dwillia2-mobl4.notmuch>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <abmcWIgaAyw66h5J@wunner.de>
 <69ba57199b38b_7ee31005c@dwillia2-mobl4.notmuch>
Date: Fri, 24 Apr 2026 15:45:17 +0530
Message-ID: <yq5a340koea2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> The ARM CCA spec does reference the EAT nonce which is 64-bytes. So it
> may be the case that PCI_TSM_MAX_NONCE_SIZE != SPDM_NONCE_SZ depending
> on what evidence can be collected over this interface, but I am not
> finding any spec references for 256, Aneesh?

That was probably me getting confused about 256 bits in an earlier
version of the code. Also, the RmiVdevMeasureParams structure layout
adds 256 bytes of padding between the different fields.

-aneesh
