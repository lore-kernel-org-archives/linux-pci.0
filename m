Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0B1C84CB;
	Sun, 11 Oct 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707055; cv=none; b=qXdaUt8J/bl9ZcQmkJfZ2eQzHrjib42BFHUi3gKeeb6Uc0YxU3oKX6JwKN3wuTI7PfeR+PEHt2vmzV7bnpHBXVv7v501vq3ldYcG52uPdcX9zkZhvYWA233RaBDxxM+2/QjDTMRcL6rrLbWGDrxcifgK/uBsI4Zftp6rLs79znw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707055; c=relaxed/simple;
	bh=aQ0R83c5/GmoW/+LVbkIPNIsyC2wPqy9smUkivEzaxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmTdPEWSkRdSKqoThIYbzkZf8hZtVqpOM4FKvw+ohM8NjpJP0RhW7L5cQlGU9CT7V5Y99xqhWiGm6IAJ2NBr1WGhX6CMwWeKG9A1IhjnbnkEES47qxTRSu7o/uhdeIZ4OJTkCzo2w7gRJ2Ac0NpZ4aR7O2csfxroTGGdvrXflzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XnL56jPo; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XnL56jPo"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j2YXp3SVNzMlW1;
	Sun, 11 Oct 2026 10:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791707050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1rb5MWjf7Z4vH2ZKyYNojgX5eHNztajNqmnS/1QK/8=;
	b=XnL56jPo9KzAHRwr43pQ6Tuq+WQv0yOanOYX5W/aVVVQmzS4ZUmksxOtMqTUPs9OxuM4Fv
	kH6oeSrWRqm5COsPI/UcIxpFWsucoIeqGqOLsN/5ObeIfjiRvLQCuNpyWh6s3VaYJkZ/no
	P0qGTIso4ln/m6F2lRyBF/G/T+KkNMpZvVsDZt+rtyvsGC0BRGd5gL/FyCWXiqaY9s++l4
	W1JNKHXYYAVyenxJGnRS0m4sJJqLz3gtRns4y9L2Xvh5Rrxfop343ETaQrcDE/dapWDB3V
	Dks3dvlIkToThL6RG5YwYmuwVyb1vIpXn+pv5OBjRON7BDDGvE22sm599pBCRA==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: lukas@wunner.de
Cc: bhelgaas@google.com,
	rafael@kernel.org,
	alex@shazbot.org,
	hui.wang@canonical.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV
Date: Sun, 11 Oct 2026 10:24:08 +0200
Message-ID: <20261011082408.17274-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <asqFthqcsDkUU6Sg@wunner.de>
References: <asqFthqcsDkUU6Sg@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: oux4k7kwefi67pfj4wtfkm8d1p43b638
X-MBO-RS-ID: bb6409fe81d4e284135

On Sat, Oct 10, 2026 at 08:36:38PM +0200, Lukas Wunner wrote:
> The code comment should be rephrased such that "returns" is replaced
> with "may return" because of the optionality of RRS Completions.

Will do in v2.

> I think it's sufficient if you just change the if-condition like this:
>
> -			if (!pci_bus_rrs_vendor_id(id))
> +			if (!pci_bus_rrs_vendor_id(id) &&
> +			    !PCI_POSSIBLE_ERROR(id)) {
>
> I don't see the need for the extra read of the Command register
> you're performing.

The Vendor ID of a VF always reads ~0, so with that condition, an FLR
of a VF below a Root Port with RRS SV would poll until the 60 s timeout
and fail.  That's why the branch without RRS SV reads the Command
register, too (see the comment above the loop).  I'll mention it in the
commit message.

Thanks,
Alexander
