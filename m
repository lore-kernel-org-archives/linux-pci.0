Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33728 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcEITUx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2016 15:20:53 -0400
Received: by mail-io0-f172.google.com with SMTP id f89so182328886ioi.0
        for <linux-pci@vger.kernel.org>; Mon, 09 May 2016 12:20:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH=XD59-jovARbODSUtofCZiby_JEa-DraRU+K80YZHwB09yMw@mail.gmail.com>
References: <CAH=XD59-jovARbODSUtofCZiby_JEa-DraRU+K80YZHwB09yMw@mail.gmail.com>
Date: Mon, 9 May 2016 12:20:51 -0700
Message-ID: <CAH=XD5-SORz1C75QacU2tEaoZ2D4TQKm_U5eNLhxRZEGL2uXBQ@mail.gmail.com>
Subject: Re: redirecting a PCIe transactions to DDR
From: Kallol Biswas <kallol@nucleodyne.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 We have a situation where incoming memory writes to RC have to be
redirected to a certain range of system memory (DDR).

 Assume there is no intel NTB in processor, and IOMMU is not enabled.

 We will start investigating and try to come up with a solution.  Any
input is welcome.

 Kallol
 Nucleodyne Systems, Inc.
