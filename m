Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C331332623;
	Mon,  3 Aug 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771812; cv=none; b=IoPkjeejNVg80pvfruwv07z7azXfO/SmolPZhYvGDi1ydcUI+shsDLkz+NvB0OBhwf+6A6KvHDtCRkXm+Oj+NJN53+ITvjObX9Tc44NXUS6wPlY7kq+ElKhuxPRd3rdfD54O4bMzMy19djSmF9GyQqjUNVOaaG6JskZZ0oNNcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771812; c=relaxed/simple;
	bh=5vNoMNh7GHKbWdanr8RiF5fPbOr5iOwOgWk2gqutXzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxnRyCGgL5n2DCmBWaCHkebihOwC+XWs3+mUJAXPmExnzMFKnziknp6YUvfqmFU5trFQzTRA55EBngPH2chGBr9i+sOxTeZxAQusol1jEpKY20G9CH0id6QoD3OYV39YipB0jvHUhtT4iN8pKzUiqcNU+Tx2FlBZnMJfurppVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HDO88D5y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HDO88D5y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6A381476;
	Mon,  3 Aug 2026 08:43:26 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADB603F66F;
	Mon,  3 Aug 2026 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785771811; bh=5vNoMNh7GHKbWdanr8RiF5fPbOr5iOwOgWk2gqutXzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDO88D5yK//qHn1WmtvZ0TBcIMliRZyk0KS6Eu7EneEJTxdiM683zylq8QupmowKC
	 V0nkLwOMOHWlrMOyzxmBtF3VvJ/2yRIPfNlFMpH9UAVn6dknJq+GokQdvECnZL3me4
	 2MoPGP0mmfvNbxmh1BgL2tZ9SJ6CFocte453NxJc=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Sizhe Liu <liusizhe5@huawei.com>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linuxarm@huawei.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PCI Trace and Tune maintainer
Date: Mon,  3 Aug 2026 16:43:18 +0100
Message-ID: <178577175149.2908939.183052513314662121.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
References: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 16 Apr 2026 10:42:19 +0100, Jonathan Cameron wrote:
> Yicong left Huawei a while back so drop both of our entries and add one for
> Sizhe Liu who will be looking after this code going forwards.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update HiSilicon PCI Trace and Tune maintainer
      https://git.kernel.org/coresight/c/c93556b74438

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
