Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C025782D
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607969; cv=none; b=UEtc/VKokzX6DL8ExWBzElgCHtH6acB8/m9KFWdcS/orb3767UisiSLxMdAnAmQiZXf3juyUrrHUJ8JEfp4Mp7q+Sxql4MMuouKjdktefmn7EVzU35nBrsNSlaSynGlT11JZOtxEvYRDMCFDILs22H4c6JwtKYHxiGAQry8V270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607969; c=relaxed/simple;
	bh=1X0tgBm1qcIuCZh24hxfbX3lx4TjsoCSzV3FOfAa0A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KySqzkmJdLsmbIsjLSVafJqpg8g94JNGTI1FPY/gAHcuR6ePc5jYxQBWHF5QDyl2G2ilWtNM8O0y32OqerO8qK8EjL5pw4m5JRKowe19MihEAcArX+PDra6uKQq3UwpkJ4Sc6rk500p9KI1upYZmVyskaqM0QY9bcKG/8SpzzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SvbSQe8X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvbSQe8X"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d3b445a84fso16395ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787607968; x=1788212768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1X0tgBm1qcIuCZh24hxfbX3lx4TjsoCSzV3FOfAa0A4=;
        b=SvbSQe8X52wuvmRdaHp469thsBK2fT1JcjI9B9L++oiFtdCdMvAHqTis8r3d4s4Dig
         Wu3Mx8RNJkdpIZEKvypAjDdHdrMuzLfXN3+3GX6ze3eJQWbruKIQ1Msyi0hn6Tr14iCf
         v1PwWUhU/RKv4cKB9mcuI7R1dlx+FywO4VE6rQFu/IGcaHGD5JbkjTNY4Rt9E8A0TRJJ
         mvnDStvToUbVBjrNRPeaIwVV7aMVv9HZoHtzDAQti1svB7L5F6V/HIy+wf+sGy7Kz06m
         G/jbUubGqh0XNeT4jGXXo58bkJgcg9qbsvsmE5DTcRK0t5in4voNihqSVLdQQ4RuVO1K
         1AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787607968; x=1788212768;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1X0tgBm1qcIuCZh24hxfbX3lx4TjsoCSzV3FOfAa0A4=;
        b=DFyv461x7Kiws1XJ8SAZTlmXmP19zcvE/Q0dPFlJ2mNmgg/0k/j06p8fKRBVTuhPfd
         hPfzJ1uNU2ekV7tXiUONCBVI93Zv302zdEkmk4KKFbJirL0Du18t5JSfX+w7s1/IM42O
         femCBPCpWX/5lPFb94WfSQDWoIEUvkuQwF0Lkpt5w7tFqpkff6RIxrHzY21UPtXGQbqy
         pW0H817APFLMezLrDrH+oTSlWkwHKn+j0iCEcN6wCIMuv54jnOvMf20BuBUL1bPavnfY
         Stk5aSOGrVSi6xadUyXnFX37sgAKJnRXtDbt6qxF0OdAvQhjr2j8/bQJOpVVLc02EjNL
         eu9A==
X-Forwarded-Encrypted: i=1; AHgh+Rqu2iP0Bx+dzqHLuIf4qhsIkxNiAWag/Xww75eZBP0GW2SHBniuK3QoP43aeZUD3WDKhuOaLxXpOok=@vger.kernel.org
X-Gm-Message-State: AFuF++negdZaHxequfYCFtqK5jpB4xNqRr+GWo2ENqvhOixhoAjWJptw
	gEpyjtDXrX53hfE1KXHlv3A3Eoo+EAF32QP9IyyxmZh6OG/HLUAcB5qx0UqjDHBN7A==
X-Gm-Gg: AR+sD13prYJnbNwxcISDPf/PG+iuCYafg7Bewst+/30xJfcioIJCuWxRx17Gwr2k3f/
	YP6ptqAN4Ye7FVwWIowE+xyCxiaIbfNXCBA2YMhthMWJ1DofPFDVWdPDydtgzKP5+WTHO/jM6+2
	4TTuSUpjA+eb2waLcHS3OXQ093J02uHLjkFEZsCRFNRMoDqCLNXAYc0kD25TGrdDeMBV842Syga
	TuovkVqQJSfXXeYryXZPnDBRe9IClDVF+yOZdsrR7fcOHEbdbAFB4kJOUSuofwvhu6YJO7W0ai9
	UKYrGo3MUB1KpsQ/AOQuF7khCd3is5/EOPkR2755TBBs4o1ssiHfhMUyBrREYtU8hcM8N3mm0jM
	3/W5JoxaIHmhW7KPZ5ucY9tmnb6mmHoxkrF7WqmCON6y9YHJNoOtpHF4P325ZMPbRr9HPDJ9eSw
	qgoKfHb16CoYUj0x785nrTOiH48F2u0E2aHPkW2pjjw0bqtsugv/32EtSxcRrYcGs7bZcYJy43i
	tevzSAGi6XY0gtG75s40JvzwZ+YXBJm0jc9oiEK3LwoK1nbI/d62ap6ZYI=
X-Received: by 2002:a17:902:f142:b0:2c0:defb:557e with SMTP id d9443c01a7336-2d6e07f52b9mr1305025ad.1.1787607967370;
        Mon, 24 Aug 2026 14:46:07 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef07a12sm2506753b3a.16.2026.08.24.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:46:06 -0700 (PDT)
Date: Mon, 24 Aug 2026 21:46:03 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 4/5] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <aoy7kcQWw2XOfmJl@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-5-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260824122347.1588592-5-praan@google.com>

On Mon, Aug 24, 2026 at 12:23:46PM +0000, Pranjal Shrivastava wrote:
>Update the driver to call pci_prepare_ats() after checking if
>pci_ats_supported() and fail the probe_device if pci_prepare_ats()
>returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
>a failure in pci_enable_ats().
>
>Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/amd/iommu.c | 40 +++++++++++++++++++++++++++++----------
> 1 file changed, 30 insertions(+), 10 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
