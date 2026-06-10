Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CF411695
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102236; cv=none; b=YUKgaEu+EzpQDA7QxqBu/RJMQYGmkncAFrlH86madDnc5koC5BnsQd7DdTTBWP7e6P1Vx0z8gvzFrFDRTHvxQIGn2mKUeiFzNy6FKIC5/904p26B1BdibqbUMnVVsrQfqLh1WwenP1YTo0bIVIJMBUnnNsoQ6/w8tdadPdJDpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102236; c=relaxed/simple;
	bh=ObZjN4PnpBeEVp+PIf3DS7ox6I4fRLdYZ2Z6oeHyCmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWqWAh3k3kFXmYPpi5zXUKmiy+W2I/lAIrhuVNeJNSdkD5Fm/1Bn40PTuk1FD5X577zm+VdcZ7rPq28qYhycg6CMF9+Ae+qvi4krsZXilVBOdIBKdxoMZJ5bv5kIlUIBH3VqgRUlV/5lV2Qu4KxekNycUyNTqZ/pmDIR61CGFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQtV0Ph+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQtV0Ph+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0b1a48855so81015ad.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781102235; x=1781707035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hztkJLAOrt3y4FASh5Bx2C0OqdOIndw7eniIOKrpzws=;
        b=DQtV0Ph+ELjeZrlrdJYfr2VECIrHkZW45XEQeEMlHhQSv3QwZCVWREo2Udx5bSy+XO
         21u12ustc8JpSQ9QA1qDvRJTFgF3fIX8IEmvIgnSwXQ+scznhKH1M53pGBiyZs/CShnj
         LdFoEwdJCHD9VuoQXEj6pjuqcfPh36CcT6SoWUS8OnQxTdrMTt7pwKEj/LFRnmwiFZqu
         Nhj1RNexedtvoyLT8ETaqUsNjPHFmEI6WRxOeTujUxdVjxWIc6DcSfNhb3HpWDvkrdJa
         tg5kjveRWVr1zX38zuHLr7gqY2eFkdax7mqjyv+y5/veaecmqao1tmEJ5Vnf1rMXTPeD
         bSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102235; x=1781707035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hztkJLAOrt3y4FASh5Bx2C0OqdOIndw7eniIOKrpzws=;
        b=qwtvpHaP+EmQ7IFcK7ruuXHOSnCezqE7NAoXWjOy4swplENpJHAKMj1rPpQ1U/57Io
         Ppha+iqLVwVul8ZJOEJzxtFX4RDdsNmXzGunBqx5BV3lAzBdRzq8MiR0+W2wItnl6idN
         x9YzM9aItOllOsJaSZPUPb/IoUdsV3NKDANhU4PztBx0kZw1JvV+2jlqGirX01aq80eU
         Sz0ySaLiVq+oyBgYPGpg8xTUxMc+6xUi0E80NS9H4U6UIcw8e78JCrRPFnv8ofdlgMMp
         k/tnrgH+xRsKFccWKPntY8NU8tEgK66FO1jFJCAWvuFqW0+bFVpOwFdlKZDbdul+FLKi
         +1WQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hCAPzGtgnX5GZ5Q/+uM5dgOa+IgfjSFZeqnerWcLfbxZkyM0kvjKrV/u5/vvJxruU0NuCPjHtnhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWEOEBTvRDvW0aUOM86E5/YyZLgOfxoZS5/rmdCgc19541BC6
	Rq53ari6s1SGmhwjU7bFb6mngnasSCXtXpRJc70nxRpuXSMlQAZiJwzyOA+m6O1Ofw==
X-Gm-Gg: Acq92OGtgvJh4VLiSuR0EZgmW8cY0W5PSial4YKOqBfgdKP6zjGEf/u69Ts6Uh6R92l
	mPnM8gDME0LR2UrZTj8Otn2GcUOD64lQ4ZWzuOA/ZMCH8/6e8+QmgD6e50dYmCp0AJmwTt6VTaT
	JUaxOqXQkqavG6NKTNMxYfxghEIRC6Fk6jkDrekCZH9RWm/AilsXUBgjE3mpWuZZTf1khEfW2ms
	TzVwTBZUvC0Ygkx3VoUtWBU6bNBKLmUCGVdjQobi7ToP7Bv/G5t07fSvLnz+FgoVCaijWwHuqJk
	wUYjuyQ/X7rdqUih8FgA5Ho/zqKB5IL3wai9KOuXAloDq/CK63051qE8eCaTD6wcoNAAxQIJ18y
	lhO3Kael8FmERUcAs4QwTGCdtFiCUVeetYkdxcNMo7x0PADFhl+CRHXRvoxIcy+FmO+fJzZTK/S
	Q/MmvJXOetvSd3S8EQ6+bieUFBQCTSKq2NiJ4L/3lgUl/W60kmD+ZrFBqts+DzqrbMqOJRjy0=
X-Received: by 2002:a17:902:d4ce:b0:2c0:b1b0:376e with SMTP id d9443c01a7336-2c2d936f08cmr13905ad.8.1781102234239;
        Wed, 10 Jun 2026 07:37:14 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821c5sm23191040b3a.32.2026.06.10.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:37:13 -0700 (PDT)
Date: Wed, 10 Jun 2026 14:37:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <ail2kLnW43fF_Sqa@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aic6mdiZ0qUJpFca@google.com>
 <aihLTgs1Y49OXQaV@google.com>
 <20260610000704.GR1962447@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610000704.GR1962447@nvidia.com>

On Tue, Jun 09, 2026 at 09:07:04PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 09, 2026 at 05:20:14PM +0000, Pranjal Shrivastava wrote:
> 
> > Now, the attacker has an opportunity with Liveupdate, since the devices
> > are already assigned, if *somehow* it flips a bit like ACS_RR, the
> 
> If this is possible then your environment is already security broken,
> no need to involve live update.

Ack. Alright.

Thanks,
Praan
