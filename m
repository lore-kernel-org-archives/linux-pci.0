Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB24A689A;
	Mon, 21 Sep 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003391; cv=none; b=CCTVbeyRIq2yeA4c2199203rkKzmv5MkB4nGqy/DFRyLbf0QrC96rDAuoFvp9Ouf00xT4QrP3eWhSL6m8gn8eJtuQ/14ZqDs6quZ4wEi0dK0MOqlHDUHUqHh4nyYOliz+CXC6Si2ezwa1LoP+W4/4caAI0XO6KlktFsI9g/Yocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003391; c=relaxed/simple;
	bh=ez8eHmDTkz9HqCY582jXa10MJiKTELvqD1mhuKy6C9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxVihhgkirfF+kGimsIhsTe+OZLZ4ngMd5viiOXC2bcyGb2D11XM1I47wxce3xq2Fw0FfgeLPZn5PBRgkNOnO300Ii/1cbC7cbOyGY/0RYsL+bmDrSIjYlZJNEKz+N2o8AJGL2hlILPZTWo3W4HB4O7wXyK2agJ7tGCnjKJTNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sujw36x3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sujw36x3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265871F000FF;
	Mon, 21 Sep 2026 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003389;
	bh=nIZxJGv0gpdWASD983DlGMxCIOhoLxPrF1ci5YJjVPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sujw36x3YKSU0M3MPnA1Rmc7FJlAc4M0XlfvqouKUow3v91GQVn/eJ4LV8Cy+sshr
	 ABSkmAv/m534G0+kU6OowlAI86wf/++qJ1LT/ybDWHNf61bZpZyct53qR0ZniklGUk
	 bpgwk/rd4QipXHu7R+PdXJo/IIUiGfJTbfh21RrgxhFPX/sP92ffStsT62yGk0cLRo
	 DyHlqxZL863JWY3D3/r99nyBg54eH8nxTgfa793zWMpahD6eerKQ1zc1pfW0F8RfI2
	 tKDd/otqHkeRc6r4CRJop7XiOOQNHvBpR0DfiQtKl83IxuN58I2uzV1b8ps9VZf5PC
	 xVAcBbzFEjIJQ==
Date: Mon, 21 Sep 2026 17:09:44 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org, airlied@redhat.com, 
	bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: fix inverted vga_tryget() return check and
 clear removed pci_dev
Message-ID: <arFItwNGp3_Sw3LC@quoll>
References: <20260919222629.3798073-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919222629.3798073-1-benquike@gmail.com>


On Sat, 19 Sep 2026 22:26:29 +0000, Hui Peng wrote:
> Fix two issues in drivers/pci/vgaarb.c:
> 
> 1. In vga_arb_device_init() / vga_arbiter_From_pci_dev(), vga_tryget()
>    returns 0 on success and a negative errno on failure, so checking if
>    (!vga_tryget(...)) is inverted and skips unlocking on success.
> 2. In vga_arbiter_del_pci_device(), clear any open vga_arb_user_init
>    priv->target references pointing to the removed pci_dev so subsequent
>    writes or close() on /dev/vga_arbiter do not dereference a freed
>    pci_dev.
> 
> Fixes: 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to drivers/pci")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



