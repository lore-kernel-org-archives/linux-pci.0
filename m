Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74C139D
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481153; cv=none; b=qsTLg9vF3xSVLJiQ6yUAWA5lVdmzX9pln1322YObv1sdh2fj/iLjlAJxUeES08tX4pTCCGIv476HEU0edjF24UP4ru/YiQ077FgiWQA3+JsLjTUpraDmXfQEQM+yrcvfO3yXRQpfMoBXTcx8ucud7K1Sqe3AezjeEdcJN2Y0F4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481153; c=relaxed/simple;
	bh=uwe6kN8WyqfY+UBMAwf/uEQNhgHeRnjqiRrg2YMQohk=;
	h=Cc:Date:Message-Id:Mime-Version:Subject:To:References:In-Reply-To:
	 Content-Type:From; b=Ixo6vmvhfok5JoQzDGOufFDoNHudZu+eid0+uwIofQI3Vo1cOKoMp9tsGHlT9zLgM2dLTHwxf38hBfavptUXWWRQij5IOnr1ssYmxvrETvfZh2DoBEnBI/XtI3hAFBSWmJZ47kLHjFZ4kKVhikgIiPdYJRtgnPR4oIfP6JZ4SyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QyHPlTdz; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QyHPlTdz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1769481138; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rLWtDbnQEeUqZTKUmguPf1NnWTuVB8OyE9HkcanCCXw=;
 b=QyHPlTdzmYmP7R7WlBv5LcPQR+NM6UgYcXe739paexp5LWb8iFFDZa/vp4pPADizcKow2l
 76aBCVZgnU53R2e+xh/UnVJNlYjeFue42a1U5mhvlr7AImgbkIg0OctBMMrAtknISYELKY
 VqBeQkfAyyK7yMg/Ogu1ma4HOpPuxJNMMfgX+TPzs7Pip8T4LUrbxYQb8pFHzcoYRLsHBu
 8tM7oQTh5/8EYN2a4Rt1dpZf7Ss2gBwxtpQwuKjEpoW9JsQL+1gW0PfVkghVx4CTU3Dwyf
 M2MF1oJt3huv7hyDJMhVmejPB9u7IOKK2SGyG8R/5rNnPjB/6RM5rlAo/+l4IQ==
Content-Transfer-Encoding: 7bit
Cc: <alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>, 
	<dakr@kernel.org>, <dan.j.williams@intel.com>, <frederic@kernel.org>, 
	<gregkh@linuxfoundation.org>, <helgaas@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, 
	<rafael@kernel.org>, <tj@kernel.org>
Date: Tue, 27 Jan 2026 10:32:00 +0800
Message-Id: <20260127023200.414-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH v2 0/3] Add NUMA-node-aware synchronous probing to driver core
X-Mailer: git-send-email 2.17.1
To: <guojinhui.liam@bytedance.com>
References: <20260126091749.307-1-guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2697823b0+60f95e+vger.kernel.org+guojinhui.liam@bytedance.com>
In-Reply-To: <20260126091749.307-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>

On Mon Jan 26, 2026 17:17:49 -0800, Jinhui Guo wrote:
> Hi Dan,
> 
> Thank you for your time, and apologies for the delayed reply.
> 
> I understand your concerns about stability and hope for better PCI regression
> handling. However, I believe introducing NUMA-node awareness to the driver
> core's asynchronous probe path is the better solution:

"asynchronous probe path" -> "synchronous probe path"

Apologies for the typo.

Best Regards,
Jinhui
