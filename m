Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64614 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3LEWuF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 17:50:05 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so29618037ieb.8
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 14:50:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131205091257.GA13010@ulmo.nvidia.com>
References: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
	<20131205064822.GB2298@pratyush-vbox>
	<C79B248886DD134989C8FF6B096A91AB92139701C9@BGMAIL01.nvidia.com>
	<CAE9FiQUqnSYFnmETkJcSeFh=5S9Qh5XsCuvA1YoXkU4608cXmQ@mail.gmail.com>
	<20131205091257.GA13010@ulmo.nvidia.com>
Date: Thu, 5 Dec 2013 14:50:05 -0800
Message-ID: <CAE9FiQWhzoM8FiuFdb_us0AYehiZN+cT4=fu9K8hYxciVtquXg@mail.gmail.com>
Subject: Re: [Discussion]: ARM: PCIE: Setup bridges not happening with portbus
 driver enabled
From: Yinghai Lu <yinghai@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jay Agarwal <jagarwal@nvidia.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 5, 2013 at 1:12 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Dec 05, 2013 at 12:27:40AM -0800, Yinghai Lu wrote:
>>
>> Please make sure you pci_assign_unassigned_resources get called via
>> fs_initcall().
>
> Why does this have to be called as fs_initcall() time? Does it have to
> be exactly then or can it be at any later time?

No, just need to make sure it is
before any consumer like pcie driver try to use pci bar resources.

Yinghai
