Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142A379C37
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615812; cv=none; b=ID10oy9Iyi81G4VAwOZKB/XY2I+RJUAxtNX1HNnyKrSdnlLfGmvss4boVsFbpGyBpGqex+3ZJTtXkIq3G8y3hetifm9KsKDfvDSp/IRFiNCGl7cehsM91rx/jzi/RLbHvDbPwtvfFT3fChVpYOB3zB7Hc04RIPJnqDo20qv+zl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615812; c=relaxed/simple;
	bh=aHAhZatWrqN63rqopsuzMRMmrjRl1erVOZnCz/D9ERs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTW98xnF8Zu+2Bot0wU+DYJF1eWQfl/S2MkGRDiuSRRgxCCoKbbFbvWbqi76MTuJo36P8qkE2MjuRVDN3ErMv/1jGczKkoYk449vvazonD2ZnjrQq93erZHjsxEjA8Um8GdELNvWDN0CQjnPEVlNCpkI60mIWVDKk4Rvxx/HbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yapk7RoF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yapk7RoF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2db33db4de9so2785ad.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790615807; x=1791220607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nVlRP8UBi3QSgtgc/PjPsjRl9sO+VgQnXuH3S8lXm6s=;
        b=Yapk7RoFBmsEjX5eE+RtnFda3ODPFWKCkJovSMY9EBJS8V/i+JQSYEJwPMiuPj8nSA
         KUI7f7+HawJv0h6JvmLUh/Cx5j2JiqteEAYoQ/sj7ltW2Y1unMI8ex7tTW5cQCRyXbY7
         3ZPAD36xrTbFYt8PQFH02Tcm0Z3wxfN7WMDu3IvlSv3tSrPnJsZK2QzBNPLav+tDIyDv
         aKN2GCtr9CWObSA2mbWrX+JyIq9zYMxBWm2+rn6B0zwuB2uRcJDqCzaYuoYDp/a7cOYS
         g/wefy2wbNBCGe4UQkMQ9ZRZp4klETxNT4saGoA2oISdVpxZpg6Y2qTI6/BbSeDt/XdH
         T1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615807; x=1791220607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVlRP8UBi3QSgtgc/PjPsjRl9sO+VgQnXuH3S8lXm6s=;
        b=oaePQf7D9eIut7+KiCuMlcBXzcaCm2rSknhTNMSbhOBsVrCiQMHew+WconaXNbJ0FH
         xpdVB3vtpeObNZpzXvX07wjF6wRCijTROd60EJAWKWLyWHObw+hfdZHAS+2YVGjDHF6S
         mm+KIFjcwc4w81L6i8vhpK173fhbCxnTBlnhHcNSXejWHUBtktDW2+4P0yhTzkpTROGA
         ar7Ka2GVTUaT7ITyuJLnJ8RLxLj6M28VK4gI/P4oKkmavtp1nUG+fTsJW5BX0mOYrozA
         oP9WMpoRLNEW+nO0hH+JLkIyEA444jlp0NM4tw7Zba5r7s74VX0z/8+5QN49OkGTmbil
         3UZg==
X-Forwarded-Encrypted: i=1; AKwUvBw4Cy/CW3sNMm4kISdfNqHdRtMk5t9+KK9n0O6yf8hSQzQ9FHHDuxFN9yRkgWOucPJu36uZiVHyBBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmwzk5G5KBzolNoh6Trdnz9ZhYbnnr/zyTYv2wFQP1bhTypXdd
	5j9gvt1cLsu/Q9JEjwcPcVUc3rROrD1Nwzy53LcjmlbYwiZ8EjSYXorwOhk6GxsSag==
X-Gm-Gg: AYBFou3BS1l0nvQmrjGcC+fXXdeytOjI76dKplTZy3zSBP72ZQZAp3bXkEqyazYBqrW
	/EChwMmqehM0uz3DkdHwgUdJjhgmXLhOG6tMImNdGBizPeiKgABe7i2EPT1w0WHQSNM9CXs3SJN
	2Rt2fYbgxf6EXZsKSGumaS28Xt1xHjdIgdZNsWzHm5vkKqgsKTT+s1D2F/WvdM4lSyHEAtkfJgj
	tmnC9gdPd7T64y+MdSnUaoByCldv/Qb5yTVvwEo2gcaEQNKkjgY7H8ZuRxVaompIlL4bof+Z4aE
	O5ETCjrUvYzXJToWwZuybnD4qZzhMS07J0DOoGbAEj/acj1CfZN4rVGfea+PAt5aHxrPwR7o++0
	SE7Fe6EvddYsKzIM59uDVQ33vfrzj9lxxhbknVPmzAsfZp4DcdB8d+pjrmkO7S1Ugk6mo4lDXEO
	UtWpfgf6UOwlCThH+oA9kdiNLbnQZ9nKZP6oBmMGcTFDw+fIfQ4iG+66q5OUuKRiHK6iXqurwPt
	Xns6GtPQvY/5Q9cSYXyGlSGGUvmMc6PkHt9
X-Received: by 2002:a17:903:b48:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2dfa6194d00mr7813665ad.2.1790615806244;
        Mon, 28 Sep 2026 10:16:46 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497edd76dsm520284a91.7.2026.09.28.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:16:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:16:36 +0000
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
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 06/13] PCI: liveupdate: Preserve bus numbers during
 Live Update
Message-ID: <arqg9G8pXKPX8WCe@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-7-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-7-dmatlack@google.com>

On Fri, Sep 18, 2026 at 08:06:32PM +0000, David Matlack wrote:
> Keep the secondary and subordinate bus numbers that the previous kernel
> programmed into bridges, rather than assigning new ones, if the previous
> kernel preserved any device across a Live Update. Do this even on
> architectures that would otherwise always assign bus numbers themselves,
> e.g. when pci=assign-busses is passed.
> 
> Preserved devices must be allowed to continue performing memory
> transactions across a Live Update, so the kernel cannot change the
> fabric topology. Changing the bus numbers of a bridge changes the
> RequesterIDs of the devices below it, which would require disabling and
> flushing any in-flight memory transactions first.
> 
> Apply the policy globally rather than only to the paths that contain
> preserved devices. Bus numbers have to be preserved above a preserved
> device anyway, since an upstream bridge cannot expand its window. A
> global policy matches the scope of pcibios_assign_all_busses(), and
> gives an answer that cannot change part way through the two passes of a
> bridge scan.
> 
> Bridges that do not have bus numbers are still assigned new ones, so
> hot-adding a bridge keeps working, both during and after a Live Update.
> The two-pass bridge scan guarantees such bridges are only assigned bus
> numbers above those already claimed by preserved bridges.
> 
> The exception is a bridge that was preserved but comes up without a
> valid bus number configuration, e.g. because it was reset during kexec.
> Refuse to assign it new bus numbers, since that would silently change
> the BDF of every preserved device in its hierarchy. Also refuse to
> assign bus numbers to the other bridges on the same bus, since the bus
> numbers of the failed bridge can no longer be read from hardware and
> handing them out would let an unrelated device inherit the BDF of a
> preserved device.
> 
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since preserving bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
