Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F1225A38;
	Sun, 11 Oct 2026 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685544; cv=none; b=Ddk+bg3cPPVMwwU7nCaj8IZ8havxIvH5o30G11AodH1tF9hk+hzaBh20dWlu/Ni5SGwDcEfiUQ1A4aSWT6qe6TABfSOw8BdBcVA7MMMQ/zDQBFGojgRIV5nvWT4GRzpsPk6BvKGh9qieKx5a4XpnH3+sWSsU2UaERmg5aX5ZvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685544; c=relaxed/simple;
	bh=xc+jaQEr5lJabAQv1EEbOH+/3yBgYIkvVhxRYboVWuQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m9b+vdRc4xFFmsJLLGiyMEKZxFbKtWP9Tj0sbhwX07scJ4dNZ2SyLJFgsmOMt3taiaQlbuJlaSND8fRMIORCX+jDaEajCLoJtV2uAXYpvXLHf7IWjtDM6tAbSRT4wb9uZGaZlqwqTDIWbfRM5PCsRl/Dgib/p01R2fvMn7bgoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VloUa1Iz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VloUa1Iz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A461F000FF;
	Sun, 11 Oct 2026 02:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685543;
	bh=xc+jaQEr5lJabAQv1EEbOH+/3yBgYIkvVhxRYboVWuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VloUa1IzQLGozve0cr6oqNTqFZNR6Mt8kACz/loqYmYbpDMYuNkNxEAC/pAXCL8lK
	 GHIQyh3L0yLv7Qo6nl9VJ68z/7jtgUINEcnKPP7HHBNAdt5AhmUqU/sEg8rd+JgWJO
	 rC7IgjS3RUGD6LeeC+mNQI57hT+UzNeGrFuvpoS18R6webWiwkMynQUWtWE8JMd4SQ
	 JWNMD1MyvziN+JxqpKJaWB2gxdc5CaynISCbOkSkWLP3ZLTp9h9EELaQL/YMDzf0J6
	 dlOwMps1/DC5afcmnevG0d75//jtQImQt4Ab0HXzt4qEVJByFMZYhBWgNGapQNxJ3Z
	 3i8UOuRp62JCg==
Message-ID: <sashiko-outbox-166978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 04/16] cxl: Embed decoder configuration in a
 standalone structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-5-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:25:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Define cxl_decoder_config independently and embed it in cxl_decoder. Upda=
te
> decoder field accesses without changing behavior, so reset snapshots can
> reuse the configuration type without struct_group_tagged().
>=20
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D4

