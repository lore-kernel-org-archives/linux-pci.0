Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:58666 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbeACMib (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 07:38:31 -0500
Subject: Re: [PATCH 04/12] PCI: qcom: account for const type of
 of_device_id.data
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-5-git-send-email-Julia.Lawall@lip6.fr>
 <20180103122237.GD26554@red-moon>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <d2b54ccb-436a-69a8-b966-d65172d01c0f@mm-sol.com>
Date: Wed, 3 Jan 2018 14:38:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180103122237.GD26554@red-moon>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 01/03/2018 02:22 PM, Lorenzo Pieralisi wrote:
> On Tue, Jan 02, 2018 at 02:28:00PM +0100, Julia Lawall wrote:
>> This driver creates various const structures that it stores in the
>> data field of an of_device_id array.
>>
>> Adding const to the declaration of the location that receives the
>> const value from the data field ensures that the compiler will
>> continue to check that the value is not modified.  Furthermore, the
>> const-discarding cast on the extraction from the data field is no
>> longer needed.
>>
>> Done using Coccinelle.
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> ---
>>  drivers/pci/dwc/pcie-qcom.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Hi Julia,

Probably that is addressed to me :)

> 
> I am happy to take this patch through the PCI tree unless you see a
> problem with that, please let me know.

The patch looks fine.

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
