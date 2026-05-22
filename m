Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECC3A5453
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437493; cv=none; b=sHJc26CIsNR5fyazXTFMsgdAdSF8lAhLIEEfaktq8rs4SqI8KC4y5zK+q4gyTx17wg4xfQ/xk726HDm8gyO1BWPVXvK7TK+oHkaXz1fKnIgzVPAtscEDNxPFSqDWpREQNf5kEbeLQWcYkb59fGMctB3GkP4ecPZHk2kmkwj0EJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437493; c=relaxed/simple;
	bh=K4PhmCwDVMYkUe0PgM4zsL2IXz6MrWUsXUSJyPnwMNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUAtxdytRrTD7j3hCBvyXL6FFtizYKP+0w+e8XGvMmvXJ1drOz0VsOaV2IQ0NToUMpVYbJYzrLPmSeiYPs0EOpIXROf3yjyCB6djYBr/eeML5E1lekRWXR3BGSJ61qAzPbzik9djMXx5UAKdn6ejhy9GAi8p4JBfLyBJRQ3Bsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 9GuaWpKZTHWO+L+3rQDmRw==
X-CSE-MsgGUID: N+/NL6s4TdS3nEyFIn9XKA==
X-IronPort-AV: E=Sophos;i="6.24,162,1774281600"; 
   d="scan'208";a="176593742"
From: weipengliang <weipengliang@xiaomi.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Frederic Weisbecker" <frederic@kernel.org>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Danilo Krummrich <dakr@kernel.org>, Uwe
 Kleine-Konig <u.kleine-koenig@baylibre.com>, Samiullah Khawaja
	<skhawaja@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, <weipengliang@xiaomi.com>
Subject: Re: [PATCH v2] PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices
Date: Fri, 22 May 2026 16:11:20 +0800
Message-ID: <20260522081120.1794-1-weipengliang@xiaomi.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <ahANoSZXPFUX3HaR@wunner.de>
References: <ahANoSZXPFUX3HaR@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX03.mioffice.cn (10.237.8.123) To YZ-MBX11.mioffice.cn
 (10.237.88.131)

On Fri, May 22, 2026 at 10:02:41AM +0200, Lukas Wunner wrote:
> Hm, looks like these two newly added lines are unnecessary.
> Am I missing something?

You're right. Since cpu_hotplug_enable() has been moved into the
branches, the early return is no longer needed -- both paths now
fall through to the common cleanup at the end.

I'll drop these two lines in v3.

Thanks,
weipengliang
