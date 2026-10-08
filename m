Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4952495ADB;
	Thu,  8 Oct 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467897; cv=none; b=JQXlIm5TQ03cDCg1QqwRFRF8Nq96fHuALID9hIgRNpkRIDxViquAXzpxPF/DiH6wejrXNVCTFJJgVpXmDnmHRhqB4jWhZETCLDE0P8zzurBY3lICLqgp2FkX1PSLbc6UxINFuTWiCU+S9Hf+qsfq9rbhUCC+9PEd20mmzzc62UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467897; c=relaxed/simple;
	bh=6vZ8Ejj8aZrBU856Cgb+Aq9cC3Vyu+mZba06VVhY2u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBOTCexBvbqHLUBrAz0NHHNtTpoU2ijDhuCHNvHju9F2kBHLBONPWTZKFUT8OeOme2jLdUS/8aSQxFQA+QWKN6+czqp21GDLs5iiyBHcZKNgtqm445VSFKrL+TocQivyLrg/OOWErbvmTnb7m0lfYsDUHFVlbuksZ7HzYp1wKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N2MldErZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N2MldErZ"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id E381620B7166;
	Thu,  8 Oct 2026 06:57:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E381620B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791467832;
	bh=6vZ8Ejj8aZrBU856Cgb+Aq9cC3Vyu+mZba06VVhY2u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2MldErZ7BuYtSeyaXTL/+JFoAjR43/8BqyXcXYCQCRU7mBNoqNY7iCRa66+DhoJX
	 rFz+UuSy554Glphg6bl8DrPa++tx9SgytfynLo4JgRkwm+R9oDAJDTHXXPDjmikCuz
	 cuG6NT1cQr9USDmP+24a9RJLxq2CC5ohAg4F2O/I=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-pci@vger.kernel.org
Cc: Frank.Li@nxp.com,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	roy.zang@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "PCI: layerscape: Change default error response behavior"
Date: Thu,  8 Oct 2026 09:57:47 -0400
Message-ID: <20261008135747.76755-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
References: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping on this fix. Please let me know if any additional changes
or testing are needed.

Thanks,
Jeff
