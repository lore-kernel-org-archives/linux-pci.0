Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9537F320
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601772; cv=none; b=qbJfWKwT81JViBBq0kBlcvYTjSRk329vgsY4OTTK3lOfry/aAZpltDDfOpdE1k3AUcJ+CI2o5uXf8HWo9R+6EYjFr8uxBa7ey4kpITujl9MtkoP5Wjrtm3ceZdpQ7jVCzEsnw4v8XdsMQQUsZr4toxSsMUg8A3G1kb3lLLeaueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601772; c=relaxed/simple;
	bh=QQxK1dMYfMEITfED9pcxrpNSHfy8AiyMMu885Ozu8Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0+ogVcbuw4MHl3ZFolWRmMQ5qZfTy1iUIu1K1s8qvj+i95Mbcj3e+LSwD3yvWkUTbMG0bGxpsPzlTWb9Dc6th1ZHOY3PRnrgyu6q6HObVW6vSmEEDmI7Xv7ngwrbQr56Ype5IMS+7KU5e+vu8yHXK88JcxBsnnUilWfhpUSRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oeMbOAgg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeMbOAgg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d3b445a84fso2765ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787601770; x=1788206570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2JSlxwskXTbuoDvNvgTyyULaG2qnymU60jxRuo89A6s=;
        b=oeMbOAggQjWf7IPVMS14ZehmqgXssmnIKoCBL7r+wbrCvwQNO55N/Uq5k0qXf5aXXe
         uHAOADa0nWgt/kD1gYHkhwJFiywr6t3LDepiRtz2ffaNNqW+2iAumyHt72uLnL1UUu0T
         8qE6rkqgQNhZ/2Sej7aq8/9g7PsorWl1XGdWyK8ZD7dbGOZlaC1vNZKVswfgLhMzd/In
         qRdQgMvsdnOIcIGwfZaNo5JLQHQxWs1CnhS26smWS1C5z7jzFxauWjCfvBS6CIIpYSiP
         6gpPjuv/55lVo/PoErh99OiE7jNZX8b4TEloGvGDNEqCZ2wejcn9znBLbBmTDTK7lxNx
         1UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601770; x=1788206570;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JSlxwskXTbuoDvNvgTyyULaG2qnymU60jxRuo89A6s=;
        b=dd19Z6/QDGlXeL0kqZ1r/TKYRJ9tzy4gSWZy0qqq/JmhPxEDfoCoL1NLFZx0eZrApd
         m2McmzZibRRIjfL9kH9VMURRTiM6H8aNQ5P5ydrQRV+GYGor85bCeyUsAaTGkz7F2wji
         x6xz6XmD+gKdOgUvbPUksHs7RXjNMhfxr5PCAPqNV1lAdoP0igntSRE+vppZW3qRyOn6
         f8D05wKIWRr1uk3wHbS9zylaVMboevrSy5siPwrFqNPdMmENRCkE73H0zf7H8wFnGzIo
         5Kl78kcyGzpneeSyZFlYN8ZeFUilgVoi2vr4y8llKf6ZdZ7RosLdUzWFA3ew+2L5hwE4
         mmgA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0BuBQiue3B4wsOO70rHDfBoqyOdx9JwQ0zv+25uiPCQ2mpUoVbX6JMtSrTE7TdezmNkmy50Je6DQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k/oCCVXN/bkkcKzCa9NkVx5Y5oimXjB8j25707BZYXUIwe6hje
	N0ot2YyS+z6r98QMijolWTigy3Zbh5iMHSaRBUHvkMencahcMGXjgM5ERjKlRGmF0Q==
X-Gm-Gg: AR+sD11AsY9HBYbWUqCYv67gpbtpeex7ubmwzu5PIwr6Q4PgKy5xwoEA1ZPjtcaeGxU
	Od7a3505o2Ak0SQEbGtngc3qt6sfUc3LlYS6SJB2U8wegoizDFPwzNLAVWdrlqWRNH1JJlOC0/B
	stqFjY5AnA8P1Dk+LhnOnoPAqSwAjo46lv0RGkT9BZwmrtrt+sEs8w0J0mPOZWZT0R0e0IlE1c9
	h0qUK803gTcXxA1xCho3ZxaOqEJgRek8AZxBX+mJ7el9klZ5ujbDlI/4Q+rpUSFk3i+lrZZFZZ+
	p26plWmsFSJmZiEYt6tgw7/jJVu46BlOn6kwwkBZ6rl0WXKmD0D/t7bEOXP9sy3e0Q2iYwmJEYX
	C4sSBs11sWcx2ur3wG0CSA212JlDOBFStzo7aTOfiXGfiwe64j1T7k80mjbd6Ym1JNztvjRRQbC
	dgWA0dunNu89lsq5/Ka1URzmabowUBv1QLnCgZ4hQqCJLT6SJnaFudLTwZVIjcVx7dmjYP+iEbL
	dNjtZv00FHoal2wlJ4c/lhzXiGq6ldr72lvMD9jrJsBkvgv9vYww04dyHY=
X-Received: by 2002:a17:902:cecb:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2d6e0830038mr894155ad.9.1787601769181;
        Mon, 24 Aug 2026 13:02:49 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645da08desm723671a91.17.2026.08.24.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:02:48 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:02:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <aoyjVL6sjG7xh9jB@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-12-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-12-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:05PM +0000, David Matlack wrote:
>Do not disable bus mastering on outgoing preserved devices during
>pci_device_shutdown() for kexec.
>
>Preserved devices must be allowed to perform memory transactions during
>a Live Update to ensure continuous operation.  Clearing the bus
>mastering bit would prevent these devices from issuing any memory
>requests while the new kernel boots.
>
>Because bridges upstream of preserved endpoint devices are also
>automatically preserved, this change also avoids clearing bus mastering
>on them. This is critical because clearing bus mastering on an upstream
>bridge prevents the bridge from forwarding memory requests upstream (i.e.
>it would prevent the endpoint device from accessing system RAM and doing
>peer-to-peer transactions with devices not downstream of the bridge).
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c | 11 +++++++++++
> drivers/pci/liveupdate.h |  6 ++++++
> drivers/pci/pci-driver.c |  7 +++++--
> 3 files changed, 22 insertions(+), 2 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
