Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:42671 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbGJCam (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 22:30:42 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 10 Jul 2015 08:00:40 +0530
Date: Fri, 10 Jul 2015 10:30:14 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/36] PCI: Don't set flags to 0 when assign resource fail
Message-ID: <20150710023014.GA16104@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
 <1436225966-27247-37-git-send-email-yinghai@kernel.org>
 <20150709033030.GA7079@richard>
 <CAE9FiQVSK9kAg-qyASpb1AoHSwQbKK33eHhFmzUjoLOftK9M4w@mail.gmail.com>
 <20150709060420.GA7465@richard>
 <CAE9FiQWnzM4x_WFZ4rXQe9db4xxXtih6_jrJDe3c-R_Djmm8Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWnzM4x_WFZ4rXQe9db4xxXtih6_jrJDe3c-R_Djmm8Hg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 09, 2015 at 09:20:08AM -0700, Yinghai Lu wrote:
>On Wed, Jul 8, 2015 at 11:04 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> This one is on top of the last one ? or replace the last one?
>
>should be just before last one.

I can't apply this on top of 

b0b9229 PCI, x86: Add pci=assign_pref_bars to re-allocate pref bars

If you could update your for-pci-v4.3-next branch, that would be more
convenient for me to do the test.


>
>Yinghai

-- 
Richard Yang
Help you, Help me

