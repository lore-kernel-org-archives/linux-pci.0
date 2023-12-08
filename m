Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A54A8E;
	Fri,  8 Dec 2023 06:36:18 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Smtx83lBMz686x7;
	Fri,  8 Dec 2023 22:36:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 548B0140680;
	Fri,  8 Dec 2023 22:36:16 +0800 (CST)
Received: from localhost (10.126.175.81) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 14:36:15 +0000
Date: Fri, 8 Dec 2023 14:36:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Kai-Heng Feng
	<kai.heng.feng@canonical.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/3] PCI/AER: Use 'Correctable' and 'Uncorrectable' spec
 terms for errors
Message-ID: <20231208143612.00000d92@Huawei.com>
In-Reply-To: <20231206224231.732765-2-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
	<20231206224231.732765-2-helgaas@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  6 Dec 2023 16:42:29 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PCIe spec classifies errors as either "Correctable" or "Uncorrectable".
> Previously we printed these as "Corrected" or "Uncorrected".  To avoid
> confusion, use the same terms as the spec.
> 
> One confusing situation is when one agent detects an error, but another
> agent is responsible for recovery, e.g., by re-attempting the operation.
> The first agent may log a "correctable" error but it has not yet been
> corrected.  The recovery agent must report an uncorrectable error if it is
> unable to recover.  If we print the first agent's error as "Corrected", it
> gives the false impression that it has already been resolved.
> 
> Sample message change:
> 
>   - pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
>   + pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com
Good to tidy this up. FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
