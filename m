Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52510 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab3LEI1l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 03:27:41 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so28191678iec.23
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 00:27:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB92139701C9@BGMAIL01.nvidia.com>
References: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
	<20131205064822.GB2298@pratyush-vbox>
	<C79B248886DD134989C8FF6B096A91AB92139701C9@BGMAIL01.nvidia.com>
Date: Thu, 5 Dec 2013 00:27:40 -0800
Message-ID: <CAE9FiQUqnSYFnmETkJcSeFh=5S9Qh5XsCuvA1YoXkU4608cXmQ@mail.gmail.com>
Subject: Re: [Discussion]: ARM: PCIE: Setup bridges not happening with portbus
 driver enabled
From: Yinghai Lu <yinghai@kernel.org>
To: Jay Agarwal <jagarwal@nvidia.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 4, 2013 at 11:38 PM, Jay Agarwal <jagarwal@nvidia.com> wrote:
>> On Thu, Dec 05, 2013 at 01:44:53PM +0800, Jay Agarwal wrote:
>> > I am seeing below issue on an ARM platform with CONFIG_PCIEPORTBUS
>> > enabled in kernel
>> >
>> > ISSUE:  Any memory access by devices fails
>> >
>> > FINDINGS:
>> >
>> > 1. No bridge windows like below are setup and probably this is not
>> > allowing any memory access by devices
>>
>> Does your RC driver calls pci_assign_unassigned_resources after
>> pci_common_init?
>>
> No it does not. Btw, I tried calling it but it also did not help and same problem.

Please make sure you pci_assign_unassigned_resources get called via
fs_initcall().

Thanks

Yinghai
