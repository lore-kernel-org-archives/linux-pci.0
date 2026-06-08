Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5B2EDD78
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920129; cv=none; b=Oc68sJdDZotY3ZiwAJ1BL/27fJkMW9nNK2u7DJrqHEuls/2nQq/3e2wBh8VXA4EVzYmaSFaFsGAKYuCIuBvzV35rve3JePDFmJtKiQCL5xHEamgxuscrKwozXCtIe8VlqW24avCzh4OQyJfXoWnRdKvSO/yfhCe8UOW5E3Uhhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920129; c=relaxed/simple;
	bh=5h565UQOW9a2IJHasBszuWYVo0+DZmzIhsjI+wT8Ku0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVBtpQCIvjW9ku8T64MbXEVBtPPWI3/Xe4eL0cewvI3osCZlIIgxorXmy+bRwbcEgnANdfWISqa1+0gtZa2uSfx4+vSMFkrTewu/FuZXxDnxQcDnt5+SHtx1WL3RGpBQkAM3bveH/Xp+Pys2XqUQ+FQ6DtJdoU/x/OOe7DSp2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brlsmJ+R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brlsmJ+R"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so374215ad.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780920126; x=1781524926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJaMwlHdD5ukSuw9Ddmz9W921lhUeR/xfWp0HtFNkEA=;
        b=brlsmJ+Ruh5zlmyZfJ2JLvhLAsoJ22cOQzIzuhos+aSu4YzmcIDO2+BQWGW6VWA/wh
         uH5C//BLz7m6ENna1PzhFSx6+eu8TbobCmBHdPje3sJLCJNxkCvQDHbVIJftBvOafA+X
         qfuzPPuH7WLsSn7riShKgzcc6T+KqpZmc55eUKrCXlXzB4KhlRj7evb09iOnI6zy0uxU
         V6IlvZUBUcbO2IuMYYq4PQE85rZbwZsth1FlfxUbbWk56WDSuT0hKnqkpHJGh3DQ5RM8
         EyuL/kpwXI+xfSSkrcXDgR7f3SdcXEkQpxU35eyGpnKc/jLt/0+1JYrOwqm1tFHZyJXE
         TbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920126; x=1781524926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJaMwlHdD5ukSuw9Ddmz9W921lhUeR/xfWp0HtFNkEA=;
        b=ayRMqOiNIu4ytejl9FVS+/4nTpx+uTzsyjeyhSAesS+NJJLdbYkYbDB6kxwQE/Umnu
         KPDFWma1KQ0m50BGePhRtEgnKreD6MWvX3usvleGX1BpFwjnotmHudj9uVXy+n/6b+/r
         uiujZzEPEW+uJ9KOAhcXGNmH/RpHFMWwWRB6mH244Q8HJld3LV2FPQWbyGM1nic7qp6W
         I3aVJa9xOMCKPJeZY8TQZo8HlqDZUhP3yRvfQyrr71Z6y86T5cb5/3L40bR79wawj29A
         9/fT3QdRBy4I59OYapO3t3sk8ad5u9c5dlgdjnyVGBYk6+FbEyFI1DX0MFQtqxl7zLSz
         FFeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WG8uqvJZOeSmvITkHGF5/M9/oeg6zZcGL02NRXfaUFxR07KbgqtEi4dnX65uMqcO93Vpil57MFmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwyXmDOVnWfZUWBb5ja+i2S4Ev0BJxOx6W8kCGUeet8g9B/0C
	ogithrdWRSxFb8joeoiTOACUB9pf5MKON+KCbti8zEMAP2Mc9A2iFGVvz376t8cwow==
X-Gm-Gg: Acq92OFPc7gMqTMsgZMtuQxIkYzTFADrR/J+aUySl8Eevc2h1lvOtxAaXd0ne4onc7G
	p3Rzl67AOYTQQFsje3HzbwQ+Yc1cwRwSwS3JGaTz9rzXqJJtOtZWJl0NmWuoxukiMQDyWwpRcyH
	LOslAqHWwJBZy6o1Erj9oGUv1koz/wtG0Dy3lVjlW7qv6hJAvvx8fCIFscKprIQUUlGU08iSrY5
	NHcX4ax/0eeG9lnClOecQg905z2Khz8DZ/DKBIlwxA0gb1rZ4+YfmSWvxTJCZ9XsMcjEvJpvNZr
	6+D6a1MztAdffhGLIysXy2F3ElS7B5+P9KCyhODZlVT6Kljasr1UCi3VeJqOan0UglBc+6vUfAd
	hOG4ptQ+8xXj+LMRd9ks05L8zj8xFetvqlIQ54ut29l+mKPii3EFO22jF8NocH0aR4XlysdvIPA
	36AQEXjZipBUx0w/mMNvgepEleDJp7UOiUVp6+lwJsrbuC+EzeDT3gdUz3Noq2bkUHq2YnRC8LN
	OM1ZOonhg==
X-Received: by 2002:a17:903:ac6:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2c1eb1dbf25mr5272565ad.10.1780920124143;
        Mon, 08 Jun 2026 05:02:04 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm180971895ad.20.2026.06.08.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:02:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:01:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 12/12] Documentation: PCI: Add documentation for Live
 Update
Message-ID: <aiavM2JWPds-mEfD@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-13-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-13-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:10PM +0000, David Matlack wrote:
> Add documentation files for the PCI subsystem's participation in Live
> Update.
> 
> These documentation files are generated from the kernel-doc comments
> in the PCI Live Update source code. They describe the File-Lifecycle
> Bound (FLB) API, the device tracking API, and the specific policies
> applied to preserved devices (such as bus number inheritance and bus
> mastering preservation).
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  Documentation/PCI/index.rst           |  1 +
>  Documentation/PCI/liveupdate.rst      | 29 +++++++++++++++++++++++++++
>  Documentation/core-api/liveupdate.rst |  1 +
>  MAINTAINERS                           |  1 +
>  4 files changed, 32 insertions(+)

The kernel-doc directives seem to be wired up properly, along with 
formatting/indentation while keeping MAINTAINERS in sync in the same go.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
