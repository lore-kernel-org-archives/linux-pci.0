Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA822FD1AA;
	Tue, 12 May 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574445; cv=none; b=J5zJ4Oij8q+ulhS+F9D7/eVyC1KfUtl4Dm6j0lW9q2DZrfCOQS+lvdtdskm6fOVLttFivgfsJfG4AJIN5fGuvzWYiTF28/OdO8P7l69MDEPLWX32q+e/QnhP57ZYmLCGORjg/JgIcoppah3XFhWzQ6Dgz3fjFjgC6QE/v/jVtNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574445; c=relaxed/simple;
	bh=MGxfkB4f1YPzv+2rQ0ibvF//HUAcwxsbrKYfamaw4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4wItfaRNfSF5CQQjDJJKMv5nXBpmWv5278W1ji00k+xjHZz0FMee19Yv8EZs8CNGGc5rpo8ZJQvSGDgigJuGWqP7xV+pgbchl4DRufTISGOZd97jKUvTujz7VG3xUo+Q2kGE8y4AQAQc4MlsM2dkBKshIC/80wUJ0FSrNHNANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxP6UpVR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxP6UpVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778574444; x=1810110444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGxfkB4f1YPzv+2rQ0ibvF//HUAcwxsbrKYfamaw4gw=;
  b=mxP6UpVRGvhUe7dC+OOKTGn5nONjvvjbQXAm9BlNlFIKEu3u0SNM8G/W
   dbM9sWVgTqvY5wGXltcPHbDfnTKiB2m53oS8RBuLyTFk5mMZnh5BZppXn
   g9bZNVr08iYBtVdJO7h1aNna86vJIVdAooYl0qdywfTVEWXTr1uWepHIr
   C0TcuSHm9CBPisgDAz0v/CWbibZxuLGHtHqnVOGROL7JSEKBHr0IveSry
   /Et8TLggmDoRfSTkK33mldZnhZI9hV5ZdHL8PLuDrnrmI/QQeIu9hwRsW
   yqvZaFg2T5BaavA2Pe3n1ue6pESDt7Qvf2q7cLM5LpFAyxPxf2SlQ4DDy
   A==;
X-CSE-ConnectionGUID: cX8URBfgTy6fINTtW9bZ0g==
X-CSE-MsgGUID: GSY7K2HoSoinQCH/rVW7rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="67005853"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="67005853"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:27:23 -0700
X-CSE-ConnectionGUID: oL6Qld/uRB+lKqPw/BF18A==
X-CSE-MsgGUID: t8LGiDMoQ1OO5IoNe+vLIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233388576"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:27:15 -0700
Date: Tue, 12 May 2026 11:27:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v7 5/8] cxl/test: Use fw_devlink_set_device()
Message-ID: <agLkYL3B4woGIDCP@ashevche-desk.local>
References: <20260511155930.34604-1-herve.codina@bootlin.com>
 <20260511155930.34604-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511155930.34604-6-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 05:59:25PM +0200, Herve Codina wrote:
> The code set directly fwnode.dev field.
> 
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


